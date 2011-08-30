module Refinery
  class Video < ActiveRecord::Base

    video_accessor :raw  
    video_accessor :mp4
    video_accessor :ogv
    video_accessor :webm
    
    attr_accessible :raw

    validates :raw, :presence => true
  
    delegate :name, :mime_type, :height, :width, :ext, :resolution, :to => :raw
  
    acts_as_indexed :fields => [:name]
  
    def self.create_from_nginx_upload(params)
      video_path = File.join(File.dirname(params[:path]), params[:file_name])
      FileUtils.mv(params[:path], video_path)
      params[:raw] = Pathname.new(video_path)
      begin
        new_video = Video.create(params)
      ensure
        FileUtils.rm(video_path)
      end
    end
    
    def async_encode(*formats)
      formats.each do |format|
        Resque.enqueue(Refinery::EncodeVideo, self.id, format)
      end
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
