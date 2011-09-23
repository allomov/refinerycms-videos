module Refinery
  module Admin
    class RawVideosController < Refinery::AdminController
      
      respond_to :html

      crudify :'refinery/raw_video',
              :title_attribute => 'title',
              :searchable => true,
              :sortable => false
            
      def create
        if nginx_upload?
          @raw_video = RawVideo.create_from_nginx_upload(nginx_params[:raw_video])
        else
          @raw_video = RawVideo.create(params[:raw_video])
        end
        
        if @raw_video
          @raw_video.async_encode(:mp4, :ogv, :webm)
          flash[:notice] = t('encoding', :scope => 'refinery.admin.raw_videos', :title => @raw_video.title)
        end
        
        respond_with [:refinery_admin, @raw_video], :location => main_app.refinery_admin_raw_videos_path
      end
      alias_method :upload, :create
      
      protected

        def nginx_upload?
          # TODO: Make this configurable
          params[:nginx_upload]
        end
        
        def nginx_params
          # TODO: Make this configurable
          params[:nginx_upload]
        end
    end
  end
end
