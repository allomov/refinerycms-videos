class CreateRawVideos < ActiveRecord::Migration

  def up
    create_table ::Refinery::RawVideo.table_name do |t|
      t.string :title
      t.string :video_name
      t.string :video_format
      t.string :video_uid
      t.string :mp4_uid
      t.string :ogv_uid
      t.string :webm_uid
      t.string :video_mime_type
      t.integer :video_v_height
      t.integer :video_v_width
      t.string :video_ext
      t.float :video_frame_rate
      t.float :video_duration
      t.integer :video_bitrate
      t.integer :video_size
      t.string :video_stream
      t.string :video_codec
      t.string :video_colorspace
      t.string :video_resolution
      t.integer :video_v_width
      t.integer :video_v_height
      t.string :video_audio_stream
      t.string :video_audio_codec
      t.integer :video_audio_sample_rate
      t.integer :video_audio_channels
      
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
