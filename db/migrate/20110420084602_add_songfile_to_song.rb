class AddSongfileToSong < ActiveRecord::Migration
  def self.up
    add_column :songs, :songfile, :string
  end

  def self.down
    remove_column :songs, :songfile
  end
end
