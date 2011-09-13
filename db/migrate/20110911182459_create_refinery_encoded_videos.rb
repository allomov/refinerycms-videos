class CreateRefineryEncodedVideos < ActiveRecord::Migration
  def change
    create_table ::Refinery::EncodedVideo.table_name do |t|
      t.string :title
      t.string :video_name
      t.string :video_format
      t.string :video_uid
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
      t.string :video_audio_stream
      t.string :video_audio_codec
      t.integer :video_audio_sample_rate
      t.integer :video_audio_channels
      t.integer :raw_video_id

      t.timestamps
    end
    
    add_index ::Refinery::EncodedVideo.table_name, :id
  end
end
