require 'spec_helper'

module Refinery
  module Admin
    describe 'Videos' do
      login_refinery_user
      
      describe "list videos" do
        context "when no videos" do
          before(:each) { Refinery::Video.delete_all }
          
          it "invites to add one" do
            visit refinery_admin_videos_path

            page.should have_content("There are no Videos yet. Click \"Add New Video\" to add your first video.")
          end
        end
  
        it "should display new video link" do
          visit refinery_admin_videos_path
    
          page.should have_content("Add new video")
          page.should have_selector("a[href*='/refinery/videos/new']")
        end
      end

      describe "create new video" do
        it "should successfully add video" do
          visit new_refinery_admin_video_path

          attach_file "video_video", Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov")
          click_button "Save"

          page.should have_content("'Test Movie' was successfully added.")
          Refinery::Video.count.should equal(1)
        end
      end
    end
  end
end