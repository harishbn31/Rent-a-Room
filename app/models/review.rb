class Review < ActiveRecord::Base
	validates_presence_of :review
	validates_numericality_of :food_rating
	validates_length_of :review ,:minimum => 5
	belongs_to :room
end
