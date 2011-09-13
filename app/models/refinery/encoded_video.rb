module Refinery
  class EncodedVideo < ActiveRecord::Base

    belongs_to :raw, :class_name => 'Refinery::RawVideo'
    
    video_accessor :video
    attr_accessible :video
    delegate :name, :format, :mime_type, :height, :width, :ext, :resolution, :to => :video

    validates :video, :presence => true
  
    acts_as_indexed :fields => [:name]
    
    scope :by_raw, proc { |vid| where(:raw_id => vid.id) }
    scope :by_format, proc { |frmt| where(:video_format => frmt) }
  end
end
