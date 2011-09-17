module Refinery
  class RawVideo < ActiveRecord::Base

    has_many :encoded_videos
    
    video_accessor :file
    attr_accessible :file
    
    delegate :name, :uid, :mime_type, :v_height, :v_width, :ext, :frame_rate, :to => :file
    delegate :duration, :bitrate, :size, :stream, :codec, :colorspace, :resolution, :to => :file
    delegate :audio_stream, :audio_codec, :audio_sample_rate, :audio_channels, :to => :file
    delegate :url, :to => :file

    validates :file, :presence => true

    acts_as_indexed :fields => [:name]
    
    class << self
      def create_from_nginx_upload(nginx_params)
        video_path = File.join(File.dirname(nginx_params[:path]), nginx_params[:file_name])
        FileUtils.mv(nginx_params[:path], video_path)
        begin
          new_video = self.create(:file => Pathname.new(video_path))
        ensure
          FileUtils.rm(video_path)
        end
      end
      
      def html5_sort(encoded_videos)
        encoded_videos.sort do |vid_1, vid_2|
          self.format_weight(vid_1.format) <=> self.format_weight(vid_2.format)
        end
      end
    end
    
    def encode(format, options = {})
      options.symbolize_keys!
      
      EncodedVideo.create! do |encoded_video|
        encoded_video.raw_video = self
        encoded_video.file = self.file.html5(format, options).apply
        encoded_video.format = format.to_s
      end
    end
    
    def async_encode(*formats)
      formats.each { |format| Resque.enqueue(Refinery::EncodeVideo, self.id, format) }
    end

    def title
      CGI::unescape(name.to_s).gsub(/\.\w+$/, '').titleize
    end
  
    def encoded?
      !self.encoded_videos.by_format('mp4').empty? && 
      !self.encoded_videos.by_format('ogv').empty? &&
      !self.encoded_videos.by_format('webm').empty?
    end
    
    private
    
      @@format_weights = {
        'mp4' => 1,
        'webm' => 2,
        'ogv' => 3
      }
      
      class << self
        def format_weight(format)
          weight = @@format_weights[format]
          weight ? weight : 0
        end
      end
    
  end
end
