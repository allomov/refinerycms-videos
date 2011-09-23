require 'spec_helper'

module Refinery
  describe 'RawVideos' do
    login_refinery_user
    
    context "when has video with one encoded child" do
      let(:encoded_video) { FactoryGirl.create(:encoded_video) }
      
      describe "#show" do
        before(:each) { visit raw_video_path(encoded_video.raw_video) }

        it "should contain a video player with the encoded video as a source" do
          page.should have_xpath('//video/source', :src => encoded_video.url)
        end
      end
    end
    
    context "when has a video with all encoded children" do
      let(:raw_video) { FactoryGirl.create(:raw_video_with_all_encoded) }
      
      describe "#show" do
        before(:each) { visit raw_video_path(raw_video) }
        
        it "should contain a video player with a source for all encoded children" do
          raw_video.encoded_videos.each do |encoded_video|
            page.should have_xpath('//video/source', :src => encoded_video.url)
          end
        end
      end
    end
  end
end
