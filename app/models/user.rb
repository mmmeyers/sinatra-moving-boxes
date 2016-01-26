class User < ActiveRecord::Base
  has_secure_password
  has_many :boxes

  def slug
    self.username.gsub(/\ /, "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|username| @username.slug == slug}
  end


end