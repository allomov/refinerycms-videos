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
      
      context "when mp4 is specified" do
        before(:all) { @encoded_video = subject.encode(:mp4) }
        
        it "should have a file with content" do
          @encoded_video.file.should_not be_nil
        end
        
        it "should have a raw_video association equal to the raw_video that called .encoded" do
          @encoded_video.raw_video.should == subject
        end
        
        it "should have a format of mp4" do
          @encoded_video.format.should == 'mp4'
        end
        
        it "should have the .mp4 file extension" do
          @encoded_video.ext.should == '.mp4'
        end
        
        it "should have video/mp4 mime type" do
          @encoded_video.mime_type.should == 'video/mp4'
        end
        
        it "should have a filename with the format's file extension" do
          @encoded_video.name.should match(/#{File.basename(subject.name, '.*')}.+\.mp4/)
        end
      end
      
      context "when ogv is specified" do
        before(:all) { @encoded_video = subject.encode(:ogv) }
        
        it "should have a file with content" do
          @encoded_video.file.should_not be_nil
        end
        
        it "should have a raw_video association equal to the raw_video that called .encoded" do
          @encoded_video.raw_video.should == subject
        end
        
        it "should have a format of ogv" do
          @encoded_video.format.should == 'ogv'
        end
        
        it "should have the .ogv file extension" do
          @encoded_video.ext.should == '.ogv'
        end
        
        it "should have video/ogg mime type" do
          @encoded_video.mime_type.should == 'video/ogg'
        end
        
        it "should have a filename with the format's file extension" do
          @encoded_video.name.should match(/#{File.basename(subject.name, '.*')}.+\.ogv/)
        end
      end
      
      context "when webm is specified" do
        before(:all) { @encoded_video = subject.encode(:webm) }
        
        it "should have a file with content" do
          @encoded_video.file.should_not be_nil
        end
        
        it "should have a raw_video association equal to the raw_video that called .encoded" do
          @encoded_video.raw_video.should == subject
        end
        
        it "should have a format of webm" do
          @encoded_video.format.should == 'webm'
        end
        
        it "should have the .webm file extension" do
          @encoded_video.ext.should == '.webm'
        end
        
        it "should have video/webm mime type" do
          @encoded_video.mime_type.should == 'video/webm'
        end
        
        it "should have a filename with the format's file extension" do
          @encoded_video.name.should match(/#{File.basename(subject.name, '.*')}.+\.webm/)
        end
      end
    end
    
    describe ".ecoded?" do
      context "when has no encoded children" do        
        subject { FactoryGirl.create(:raw_video) }

        it "should return false" do
          subject.should_not be_encoded
        end
      end
      
      context "when has at least one, but not all encoded children" do
        subject { FactoryGirl.create(:raw_video_with_encoded) }
        
        it "should return false" do
          subject.should_not be_encoded
        end
      end
      
      context "when has all encoded children" do
        subject { FactoryGirl.create(:raw_video_with_all_encoded) }
        
        it "should return true" do
          subject.should be_encoded
        end
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
    
    describe "@html5_sort" do
      context "when has all encoded children" do
        subject { FactoryGirl.create(:raw_video_with_all_encoded) }
        
        it "should return encoded_videos in the proper html5 order" do
          sorted_videos = subject.class.html5_sort(subject.encoded_videos)
          
          sorted_videos[0].format.should == 'mp4'
          sorted_videos[1].format.should == 'webm'
          sorted_videos[2].format.should == 'ogv'
        end
      end
    end
    
  end
end
