module Refinery
  module Admin
    class VideosController < ::Admin::BaseController

      crudify :'refinery/video',
              :title_attribute => 'title',
              :searchable => true,
              :sortable => false
            
      def create
        @video = Video.create_from_nginx_upload(params[:video])
        Resque.enqueue(EncodeVideo, @video.id, :mp4)
        Resque.enqueue(EncodeVideo, @video.id, :ogv)
        Resque.enqueue(EncodeVideo, @video.id, :webm)
      
        redirect_to refinery_admin_videos_path, :notice => "Video successfully created. Encoding process will start shortly."
      end
      alias_method :upload, :create
    end
  end
end
