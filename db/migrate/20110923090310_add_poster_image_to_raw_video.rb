class AddPosterImageToRawVideo < ActiveRecord::Migration
  def change
    add_column :refinery_raw_videos, :poster_image_id, :integer
  end
end
