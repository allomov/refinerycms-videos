module Refinery
  module Admin
    class RawVideosController < Refinery::AdminController
      
      respond_to :html

      crudify :'refinery/raw_video',
              :title_attribute => 'title',
              :searchable => true,
              :sortable => false
            
      def create
        @raw_video = RawVideo.create_video(params)
        
        if @raw_video
          @raw_video.async_encode(:mp4, :ogv, :webm)
          flash[:notice] = t('encoding', :scope => 'refinery.admin.raw_videos', :title => @raw_video.title)
        end
        
        respond_with [:refinery_admin, @raw_video], :location => main_app.refinery_admin_raw_videos_path
      end
      alias_method :upload, :create
      
    end
  end
end
