require 'spec_helper'

module Refinery
  describe EncodeVideo do
    let!(:raw_video) { FactoryGirl.create(:raw_video) }
    
    describe ".perform" do
      before(:all) do
        EncodedVideo.delete_all
        subject.class.perform(raw_video.id, :mp4)
      end
      
      it "should create a new EncodedVideo" do
        EncodedVideo.all.should have(1).items
      end
      
      it "should encode the raw video into the format specified" do
        pending
        encoded_videos = EncodedVideo.by_raw(raw_video)
        encoded_videos.first.format.should be(:mp4)
      end
    end
    
  end
end
