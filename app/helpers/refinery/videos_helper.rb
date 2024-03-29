module Refinery
  module VideosHelper
    def render_video_player(raw_video)
      video_urls = RawVideo.html5_sort(raw_video.encoded_videos).collect do |encoded_video|
        encoded_video.remote_url
      end
      
      video_tag(video_urls, 
        :class => "sublime", 
        :size => "768x428", 
        :poster => raw_video.poster_image_url,
        :preload => "none"
      )
    end
  end
end
