class Song < ActiveRecord::Base
mount_uploader :songfile, SongfileUploader
belongs_to :artist
belongs_to :user
end
