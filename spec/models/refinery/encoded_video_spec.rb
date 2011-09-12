require 'spec_helper'

module Refinery
  describe EncodedVideo do
    let(:encoded_video) { FactoryGirl.create(:encoded_video) }
    
    describe "by_raw scope" do
      it "should return the original raw video" do
        raw_videos = subject.class.by_raw(encoded_video.raw)
        raw_videos.should be_a(ActiveRecord::Relation)
        raw_videos.first.should be_a(Refinery::EncodedVideo)
        raw_videos.first.should == encoded_video
      end
    end
    
    describe "by_format scope" do
      it "should return videos of the given format" do
        pending
        raw_videos = subject.class.by_format('mp4')
        raw_videos.should be_a(ActiveRecord::Relation)
        raw_videos.first.should be_a(Refinery::EncodedVideo)
        raw_videos.first.format.should == 'mp4'
      end
    end
  end
end
