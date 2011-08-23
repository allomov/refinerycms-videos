require 'spec_helper'

describe 'upload video' do
  login_refinery_user
  
  context "when no videos" do
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
