Refinery::Application.routes.draw do
  scope(:module => 'refinery') do
    resources :videos, :only => [:index, :show]
  
    scope(:path => 'refinery', :as => 'refinery_admin', :module => 'admin') do
      resources :videos, :except => :show do
        collection do
          post :upload
          post :update_positions
        end
      end
    end
  end
end
