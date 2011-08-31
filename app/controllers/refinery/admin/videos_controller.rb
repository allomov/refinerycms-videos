module Refinery
  module Admin
    class VideosController < ::Admin::BaseController
      
      respond_to :html

      crudify :'refinery/video',
              :title_attribute => 'title',
              :searchable => true,
              :sortable => false
            
      def create
        if nginx_upload?
          @video = Video.create_from_nginx_upload(params[:video])
        else
          @video = Video.create(params[:video])
        end
        
        if @video
          @video.async_encode(:mp4, :ogv, :webm)
          flash[:notice] = t('encoding', :scope => 'refinery.admin.videos')
        end
        
        respond_with [:refinery_admin, @video], :location => main_app.refinery_admin_videos_path
      end
      alias_method :upload, :create
    end
    
    protected
      
      def nginx_upload?
        params[:video][:path] && params[:video][:file_name]
      end

  end
end
