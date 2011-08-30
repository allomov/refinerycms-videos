module Refinery
  module Admin
    class VideosController < ::Admin::BaseController

      crudify :'refinery/video',
              :title_attribute => 'title',
              :searchable => true,
              :sortable => false
            
      def create
        @video = Video.create_from_nginx_upload(params[:video])
        @video.async_encode(:mp4, :ogv, :webm)
      
        redirect_to main_app.refinery_admin_videos_path, :notice => "Video successfully created. Encoding process will start shortly."
      end
      alias_method :upload, :create
    end
  end
end
