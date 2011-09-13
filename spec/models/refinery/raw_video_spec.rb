require 'spec_helper'

module Refinery
  describe RawVideo do
    subject { FactoryGirl.create(:raw_video) }
    
    describe "validations" do
      it "rejects nil value for file" do
        subject.file = nil
        subject.should_not be_valid
      end
    end
    
    describe ".async_encode" do
      context "when given one format to encode" do
        it "should place a job on the Resque job queue" do
          ::Resque.should_receive(:enqueue).with(Refinery::EncodeVideo, anything, :mp4)
          subject.async_encode(:mp4)
        end
      end
      
      context "when given multiple formats to encode" do
        it "should place the same amount of jobs on the Resque job queue" do
          ::Resque.should_receive(:enqueue).with(Refinery::EncodeVideo, anything, :mp4)
          ::Resque.should_receive(:enqueue).with(Refinery::EncodeVideo, anything, :ogv)
          ::Resque.should_receive(:enqueue).with(Refinery::EncodeVideo, anything, :webm)
          subject.async_encode(:mp4, :ogv, :webm)
        end
      end
    end
    
    describe ".encode" do
      before(:each) { EncodedVideo.delete_all }
      
      it "should create a valid new encoded video" do
        encoded_video = subject.encode(:mp4)
        
        encoded_video.raw_video.should == subject
        encoded_video.format.should == 'mp4'
        encoded_video.file.should_not be_nil
      end
    end

    describe "delegators" do
      describe "url" do
        it "should return the same value as the url of file" do
          subject.url.should == subject.file.url
        end
      end
    end
    
  end
end
