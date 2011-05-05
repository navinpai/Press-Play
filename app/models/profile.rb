class Profile < ActiveRecord::Base
attr_accessible :name,:image
mount_uploader :image, ImageUploader
belongs_to :user
end
