require 'spec_helper'

module Refinery
  module Admin
    describe 'RawVideos' do
      login_refinery_user
      
      describe "list videos" do
        context "when no videos" do
          before(:each) { Refinery::RawVideo.delete_all }
          
          it "invites to add one" do
            visit refinery_admin_raw_videos_path

            page.should have_content("There are no Videos yet. Click \"Add New Video\" to add your first video.")
          end
        end
  
        it "should display new video link" do
          visit refinery_admin_raw_videos_path
    
          page.should have_content("Add new video")
          page.should have_selector("a[href*='/refinery/videos/new']")
        end
        
        context "when has raw video with no encoded children" do
          let!(:raw_video) { FactoryGirl.create(:raw_video) }
          
          it "should display one video" do
            visit refinery_admin_raw_videos_path
            
            page.should have_content(raw_video.title)
          end
          
          it "should say the video is currently encoding" do
            visit refinery_admin_raw_videos_path
            
            page.should have_content("Video is encoding")
          end
          
          it "should display unencoded icons for each format" do
            pending
          end
        end
        
        context "when has a raw video with all encoded children" do
          let!(:raw_video) { FactoryGirl.create(:raw_video_with_all_encoded) }

          it "should display one video" do
            visit refinery_admin_raw_videos_path
            
            page.should have_content(raw_video.title)
          end
          
          it "should not say the video is currently encoding" do
            visit refinery_admin_raw_videos_path
            
            page.should_not have_content("Video is encoding")
          end
        end
      end
      
      describe "#new" do
        context "when upload_progress_uri is set to defualt (nil)" do
          it "should not show an upload progress bar" do
            visit new_refinery_admin_raw_video_path
            
            page.should_not have_css('div#progressbar')
          end
        end
        
        context "when upload_progress_uri is set to /progress" do
          before(:each) { Refinery::Videos::Options.upload_progress_uri = '/progress' }
          
          it "should show an upload progress bar" do
            visit new_refinery_admin_raw_video_path
            
            page.should have_css('div#progressbar')
          end
        end
      end
      
      describe "create new video" do
        it "should successfully add video" do
          visit new_refinery_admin_raw_video_path

          attach_file "raw_video_file", Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov")
          
          raw_video = RawVideo.new(:file => Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov"))
          RawVideo.stub(:create).and_return(raw_video)
          raw_video.should_receive(:async_encode).with(:mp4, :ogv, :webm)
          
          click_button "Save"

          page.should have_content("Test Movie' successfully added. Encoding process will start shortly.")
        end
      end
    end
  end
end