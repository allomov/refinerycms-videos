module Refinery
  module Videos
    class Options
      include Rails::Railtie::Configurable

      DEFAULT_USE_NGINX_UPLOAD_MODULE = false

      cattr_accessor :use_nginx_upload_module
      self.use_nginx_upload_module = DEFAULT_USE_NGINX_UPLOAD_MODULE

      class << self
        def reset!
          self.use_nginx_upload_module = DEFAULT_USE_NGINX_UPLOAD_MODULE
        end
      end
    end
  end
end
