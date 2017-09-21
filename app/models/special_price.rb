class SpecialPrice < ActiveRecord::Base
	validates_presence_of :start_date,:end_date,:price
	validates_numericality_of :price
	belongs_to :booking
	belongs_to :room
end
