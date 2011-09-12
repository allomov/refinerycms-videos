require 'spec_helper'

module Refinery
  describe Video do
    let!(:video) { FactoryGirl.create(:video) }
    
    describe "validations" do
      it "rejects nil value for raw" do
        video.video = nil
        video.should_not be_valid
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

  end
end
