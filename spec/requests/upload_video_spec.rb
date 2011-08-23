require 'spec_helper'

describe 'upload video' do
  login_refinery_user
    
  describe "new/create" do
    it "should go to new video page" do
      visit refinery_admin_videos_path
      
      click_link "Add new video"
      
      attach_file "video_video", Refinery::Videos::Engine.root.join("spec/samples/test-movie.mov")
      click_button "Save"
      
      page.should have_content("'Test Movie' was successfully added.")
      Refinery::Video.count.should equal(1)
    end
  end

end
