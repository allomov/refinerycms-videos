require 'dragonfly-ffmpeg'

module Refinery
  module Videos
    class Engine < Rails::Engine      
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      initializer 'videos-with-dragonfly', :before => :load_config_initializers do |app|
        app_videos = Dragonfly[:videos]
        app_videos.configure_with(:rails) do |c|
          c.datastore.root_path = Rails.root.join('public', 'system', 'videos').to_s
          c.url_format = '/system/videos/:job/:basename.:format'
          c.secret = Refinery::Setting.find_or_set(:dragonfly_secret,
                                                 Array.new(24) { rand(256) }.pack('C*').unpack('H*').first)
        end
                
        app_videos.define_macro(ActiveRecord::Base, :video_accessor)
        app_videos.analyser.register(Dragonfly::Analysis::FileCommandAnalyser)
        app_videos.configure_with(:ffmpeg)
        app_videos.register_mime_type(:mp4, 'video/mp4')
        app_videos.register_mime_type(:ogv, 'video/ogg')
        app_videos.register_mime_type(:webm, 'video/webm')
        
        app.config.middleware.insert 0, 'Dragonfly::Middleware', :videos
      end
      
      initializer "resque" do |app|
        require 'resque'
        require 'resque/server'
        resque_config = YAML.load_file(Rails.root.join('config', 'resque.yml').to_s)
        Resque.redis = resque_config[Rails.env]
      end
      
      initializer "init plugin", :after => :set_routes_reloader do |app|
        Refinery::Plugin.register do |plugin|
          plugin.name = "videos"
          plugin.url = app.routes.url_helpers.refinery_admin_videos_path
          plugin.menu_match = /^\/?(admin|refinery)\/?(gumballs|gumball_entries)/
          plugin.activity = {
            :class => Video,
            :title => 'name'
          }
        end
      end
    end
  end
end
