require 'spec_helper'

module Refinery
  describe EncodedVideo do
    subject { FactoryGirl.create(:encoded_video) }
    
    describe "validations" do
      it "rejects nil value for file" do
        subject.file = nil
        subject.should_not be_valid
      end
      
      it "rejects nil value for format" do
        subject.format = nil
        subject.should_not be_valid
      end
      
      it "rejects nil value for raw_video_id" do
        subject.raw_video_id = nil
        subject.should_not be_valid
      end
    end
        
    describe "by_format scope" do      
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
          subject.url.should == subject.file.url
        end
      end
      
      describe "remote_url" do
        it "should return the same value as the remote_url of the file" do
          subject.remote_url.should == subject.file.remote_url
        end
      end
    end
  end
end
