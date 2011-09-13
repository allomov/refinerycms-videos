module Refinery
  module VideosHelper
    def render_video_player(raw_video)
      video_urls = [raw_video.file.url]
      video_urls | raw_video.encoded_videos.collect do |encoded_video|
        encoded_video.file.url
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
