class Playlist < ActiveRecord::Base
belongs_to :user
has_many :songs, :through => :connections
end
