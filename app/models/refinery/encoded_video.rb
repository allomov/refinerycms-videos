module Refinery
  class EncodedVideo < ActiveRecord::Base

    belongs_to :raw_video
    
    video_accessor :video
    attr_accessible :video
    delegate :name, :format, :uid, :mime_type, :v_height, :v_width, :ext, :frame_rate, :to => :video
    delegate :duration, :bitrate, :size, :stream, :codec, :colorspace, :resolution, :to => :video
    delegate :audio_stream, :audio_codec, :audio_sample_rate, :audio_channels, :to => :video

    validates :video, :presence => true
  
    acts_as_indexed :fields => [:name]
    
    scope :by_raw, proc { |vid| where(:raw_video_id => vid.id) }
    scope :by_format, proc { |frmt| where(:video_format => frmt) }
  end
end
