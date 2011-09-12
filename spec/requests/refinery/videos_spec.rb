require 'spec_helper'

module Refinery
  describe 'Videos' do
    login_refinery_user
    
    context "when has video with an encoded video" do
      let(:encoded_video) { FactoryGirl.create(:encoded_video) }
      
      describe "#show" do
        before(:each) { visit video_path(encoded_video.raw) }
        
        it "should display the raw video" do
          pending
          page.should have_selector('video source', :src => encoded_video.raw.video.url)
        end
        
        it "should display the encoded video" do
          pending
          page.should have_selector('video source', :src => encoded_video.video.url)
        end
      end
    end
  end
end
