class Box < ActiveRecord::Base
  has_many :items
  belongs_to :user

  def slug
    self.name.gsub(/\W+/, '').downcase
  end

  def self.find_by_slug(slug)
    self.all.find {|box| box.slug == slug}
    self.find_by(:name => @name)
  end


end