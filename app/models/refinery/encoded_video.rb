module Refinery
  class EncodedVideo < ActiveRecord::Base

    belongs_to :raw_video
    
    video_accessor :file
    attr_accessible :file
    delegate :name, :uid, :mime_type, :v_height, :v_width, :ext, :frame_rate, :to => :file
    delegate :duration, :bitrate, :size, :stream, :codec, :colorspace, :resolution, :to => :file
    delegate :audio_stream, :audio_codec, :audio_sample_rate, :audio_channels, :to => :file
    delegate :url, :remote_url, :to => :file

    validates :file, :presence => true
    validates :raw_video, :presence => true
    validates :format, :presence => true
  
    acts_as_indexed :fields => [:name]
    
    scope :by_format, proc { |frmt| where(:format => frmt) }
    
  end
end
