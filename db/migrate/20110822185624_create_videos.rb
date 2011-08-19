class CreateVideos < ActiveRecord::Migration

  def self.up
    create_table ::Refinery::Video.table_name do |t|
      t.string :title
      t.string :raw_name
      t.string :raw_uid
      t.string :mp4_uid
      t.string :ogv_uid
      t.string :webm_uid
      t.string :raw_mime_type
      t.integer :raw_v_height
      t.integer :raw_v_width
      t.string :raw_ext
      t.float :raw_frame_rate
      t.float :raw_duration
      t.integer :raw_bitrate
      t.integer :raw_size
      t.string :raw_stream
      t.string :raw_codec
      t.string :raw_colorspace
      t.string :raw_resolution
      t.integer :raw_v_width
      t.integer :raw_v_height
      t.string :raw_audio_stream
      t.string :raw_audio_codec
      t.integer :raw_audio_sample_rate
      t.integer :raw_audio_channels
      t.timestamps
    end

    add_index ::Refinery::Video.table_name, :id
  end

  def self.down
    ::Refinery::UserPlugin.destroy_all(:name => "videos")

    ::Refinery::Page.delete_all(:link_url => "/videos")

    drop_table ::Refinery::Video.table_name
  end

end
