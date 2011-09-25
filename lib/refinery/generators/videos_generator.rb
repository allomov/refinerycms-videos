module Refinery
  class VideosGenerator < Refinery::Generators::EngineInstaller

    source_root File.expand_path('../../../../', __FILE__)
    engine_name "refinerycms-videos"
    
    def generate_videos_initializer
      template "lib/refinery/generators/templates/config/initializers/refinery_videos.rb.erb", destination_path.join("config", "initializers", "refinery_videos.rb")
    end
    
  end
end
