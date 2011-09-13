require 'spec_helper'

module Refinery
  describe EncodeVideo do
    let(:raw_video) { FactoryGirl.create(:raw_video) }
    
    describe ".perform" do
      before(:each) do
        EncodedVideo.delete_all
        subject.class.perform(raw_video.id, :mp4)
      end
      
      it "should create a new EncodedVideo" do
        EncodedVideo.all.should have(1).items
      end
    end
    
  end
end
