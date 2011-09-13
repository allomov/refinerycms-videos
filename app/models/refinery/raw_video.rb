module Refinery
  class RawVideo < ActiveRecord::Base

    has_many :encoded_videos
    
    video_accessor :file
    attr_accessible :file
    delegate :name, :format, :uid, :mime_type, :v_height, :v_width, :ext, :frame_rate, :to => :file
    delegate :duration, :bitrate, :size, :stream, :codec, :colorspace, :resolution, :to => :file
    delegate :audio_stream, :audio_codec, :audio_sample_rate, :audio_channels, :to => :file

    validates :file, :presence => true

    acts_as_indexed :fields => [:name]

    def self.create_from_nginx_upload(params)
      video_path = File.join(File.dirname(params[:path]), params[:file_name])
      FileUtils.mv(params[:path], video_path)
      params[:file] = Pathname.new(video_path)
      begin
        new_video = self.create(params)
      ensure
        FileUtils.rm(video_path)
      end
    end
    
    def encode(format, options = {})
      options.symbolize_keys!
      
      encoded_file = self.file.html5(format, options).apply
      EncodedVideo.create!(:raw_video => self, :file => encoded_file)
    end
    
    def async_encode(*formats)
      formats.each { |format| Resque.enqueue(Refinery::EncodeVideo, self.id, format) }
    end
  
    # Returns a titleized version of the filename
    # my_file.pdf returns My File
    def title
      CGI::unescape(name.to_s).gsub(/\.\w+$/, '').titleize
    end
  
    def encoded?
      self.mp4.present? && self.ogv.present? && self.webm.present?
    end
    
  end
end
