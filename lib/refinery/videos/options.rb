module Refinery
  module Videos
    class Options
      include Rails::Railtie::Configurable

      DEFAULT_USE_NGINX_UPLOAD_MODULE = false
      DEFAULT_UPLOAD_PROGRESS_URI = nil

      cattr_accessor :use_nginx_upload_module
      self.use_nginx_upload_module = DEFAULT_USE_NGINX_UPLOAD_MODULE
      
      cattr_accessor :upload_progress_uri
      self.upload_progress_uri = DEFAULT_UPLOAD_PROGRESS_URI

      class << self
        def reset!
          self.use_nginx_upload_module = DEFAULT_USE_NGINX_UPLOAD_MODULE
          self.upload_progress_uri = DEFAULT_UPLOAD_PROGRESS_URI
        end
      end
    end
  end
end
