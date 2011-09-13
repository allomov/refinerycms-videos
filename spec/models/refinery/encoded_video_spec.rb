require 'spec_helper'

module Refinery
  describe EncodedVideo do
    let(:encoded_video) { FactoryGirl.create(:encoded_video) }
    
    describe "validations" do
      it "rejects nil value for file" do
        encoded_video.file = nil
        encoded_video.should_not be_valid
      end
      
      it "rejects nil value for format" do
        encoded_video.format = nil
        encoded_video.should_not be_valid
      end
      
      it "rejects nil value for raw_video_id" do
        encoded_video.raw_video_id = nil
        encoded_video.should_not be_valid
      end
    end
        
    describe "by_format scope" do
      let!(:encoded_video) { FactoryGirl.create(:encoded_video) }
      
      it "should return videos of the given format" do
        raw_videos = subject.class.by_format('mp4')

        raw_videos.should be_a(ActiveRecord::Relation)
        raw_videos.first.should be_a(Refinery::EncodedVideo)
        raw_videos.first.format.should == 'mp4'
      end
    end
    
    describe "delegators" do
      describe "url" do
        it "should return the same value as the url of file" do
          encoded_video.url.should == encoded_video.file.url
        end
      end
    end
  end
end
