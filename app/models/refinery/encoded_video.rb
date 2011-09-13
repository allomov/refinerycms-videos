module Refinery
  class EncodedVideo < ActiveRecord::Base

    belongs_to :raw_video
    
    video_accessor :file
    attr_accessible :file
    delegate :name, :format, :uid, :mime_type, :v_height, :v_width, :ext, :frame_rate, :to => :file
    delegate :duration, :bitrate, :size, :stream, :codec, :colorspace, :resolution, :to => :file
    delegate :audio_stream, :audio_codec, :audio_sample_rate, :audio_channels, :to => :file

    validates :file, :presence => true
  
    acts_as_indexed :fields => [:name]
    
    scope :by_raw, proc { |vid| where(:raw_video_id => vid.id) }
    scope :by_format, proc { |frmt| where(:video_format => frmt) }
    
  end
end
