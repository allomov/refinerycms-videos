class CreateRefineryEncodedVideos < ActiveRecord::Migration
  def change
    create_table ::Refinery::EncodedVideo.table_name do |t|
      t.string :format
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
      t.integer :raw_video_id

      t.timestamps
    end
    
    add_index ::Refinery::EncodedVideo.table_name, :id
  end
end
