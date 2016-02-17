class Website < ActiveRecord::Base
	belongs_to :webpage
	has_many :links, dependent: :destroy

	def self.latest_links
		Website.order("depth_level DESC")
	end

	def self.depth
		if web = Website.order("depth_level DESC").first
			web.depth_level
		else
			0
		end
	end

	def self.output
	end
end
