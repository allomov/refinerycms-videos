module Refinery
  class EncodeVideo
    @queue = 'encode_video'
  
    def self.perform(video_id, format, options = {})
      options.symbolize_keys!
    
      @video = Video.find(video_id)
      encoded_video = @video.raw.html5(format, options).apply
      @video.send("#{format}=", encoded_video.temp_object)
      @video.save
    end
  end
end
