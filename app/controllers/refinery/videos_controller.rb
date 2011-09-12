module Refinery
  class VideosController < ::ApplicationController
    
    respond_to :html

    def show
      @video = Video.find(params[:id])

      respond_with(@video)
    end

  end
end
