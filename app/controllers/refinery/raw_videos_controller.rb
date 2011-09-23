module Refinery
  class RawVideosController < ::ApplicationController
    
    respond_to :html

    def show
      @raw_video = RawVideo.find(params[:id])

      respond_with(@raw_video)
    end

  end
end
