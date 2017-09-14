class City < ActiveRecord::Base
	validates_presence_of :name
	has_many :rooms
end