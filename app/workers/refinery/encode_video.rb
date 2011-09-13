module Refinery
  class EncodeVideo
    @queue = :encode_video
  
    def self.perform(video_id, format, options = {})
      options.symbolize_keys!
    
      @raw_video = RawVideo.find(video_id)
      @encoded_video = EncodedVideo.new(:raw_video => @raw_video)
      # Encode the raw video and assign it to the EncodedVideo object
      @encoded_video.file = @raw_video.file.html5(format, options).apply
      @encoded_video.save!
    end
  end
end
