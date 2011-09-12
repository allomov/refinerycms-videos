module Refinery
  module VideosHelper
    def render_video_player(video)
      video_urls = [video.video.url]
      video_urls | video.encoded_videos.collect do |encoded_video|
        encoded_video.video.url
      end
      
      video_tag(video_urls, 
        :class => "sublime", 
        :size => "768x428", 
        :poster => "/images/games/tera/tera_3M_poster.jpg", 
        :preload => "none"
      )
    end
  end
end
