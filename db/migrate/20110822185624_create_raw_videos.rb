class CreateRawVideos < ActiveRecord::Migration
  def up
    create_table ::Refinery::RawVideo.table_name do |t|
      t.string :file_name
      t.string :file_uid
      t.string :file_mime_type
      t.integer :file_v_height
      t.integer :file_v_width
      t.string :file_ext
      t.float :file_frame_rate
      t.float :file_duration
      t.integer :file_bitrate
      t.integer :file_size
      t.string :file_stream
      t.string :file_codec
      t.string :file_colorspace
      t.string :file_resolution
      t.string :file_audio_stream
      t.string :file_audio_codec
      t.integer :file_audio_sample_rate
      t.integer :file_audio_channels
      
      t.timestamps
    end

    add_index ::Refinery::RawVideo.table_name, :id
  end

  def down
    ::Refinery::UserPlugin.destroy_all(:name => "videos")

    ::Refinery::Page.delete_all(:link_url => "/videos")

    drop_table ::Refinery::RawVideo.table_name
  end

end
