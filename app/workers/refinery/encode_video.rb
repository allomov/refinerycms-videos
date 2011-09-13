module Refinery
  class EncodeVideo
    @queue = :encode_video
  
    def self.perform(video_id, format, options = {})    
      @raw_video = RawVideo.find(video_id)
      @raw_video.encode(format, options)
    end
  end
end
