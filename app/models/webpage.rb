class Webpage < ActiveRecord::Base
  belongs_to :link
  has_one :website, dependent: :destroy


  def create_website
  	self.website = Website.create(url: self.link.url, depth_level: self.link.website.depth_level+1, title: self.title)
  end
end
