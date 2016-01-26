class Box < ActiveRecord::Base
  has_many :items
  belongs_to :user

  def slug
    name.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|box| box.slug == slug}
  end


end