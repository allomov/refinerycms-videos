module Refinery
  class EncodeVideo
    @queue = :encode_video
  
    def self.perform(video_id, format, options = {})
      options.symbolize_keys!
    
      @video = Video.find(video_id)
      @encoded_video = EncodedVideo.new(:raw => @video)
      # Encode the raw video and assign it to the EncodedVideo object
      @encoded_video.video = @video.video.html5(format, options).apply
      @encoded_video.save!
    end
  end
end
