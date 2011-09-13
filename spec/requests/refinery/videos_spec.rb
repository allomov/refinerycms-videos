require 'spec_helper'

module Refinery
  describe 'Videos' do
    login_refinery_user
    
    context "when has video with an encoded video" do
      let(:encoded_video) { FactoryGirl.create(:encoded_video) }
      
      describe "#show" do
        before(:each) { visit video_path(encoded_video.raw_video) }
                
        it "should contain a video player with the encoded video as a source" do
          page.should have_xpath('//video/source', :src => encoded_video.url)
        end
      end
    end
  end
end
