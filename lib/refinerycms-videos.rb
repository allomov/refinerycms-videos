module Refinery
  module Videos
    autoload :Version, 'refinery/videos/version'
    
    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end

      def version
        Version.to_s
      end
    end
  end
end

require 'refinery/videos/engine' if defined?(Rails)
