class Link < ActiveRecord::Base
  belongs_to :website
  has_one :webpage, dependent: :destroy
end
