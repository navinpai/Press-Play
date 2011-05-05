class AddArtistIdToSong < ActiveRecord::Migration
  def self.up
    add_column :songs, :artist_id, :integer
  end

  def self.down
    remove_column :songs, :artist_id
  end
end
