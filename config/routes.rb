Refinery::Application.routes.draw do
  scope(:module => 'refinery') do
    resources :raw_videos, :path => 'videos', :only => [:show]
  
    scope(:module => 'admin', :path => 'refinery', :as => 'refinery_admin') do
      resources :raw_videos, :path => 'videos', :except => :show do
        collection do
          post :upload
          post :update_positions
        end
      end
    end
  end
end
