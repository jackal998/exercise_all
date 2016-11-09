class Event < ApplicationRecord
	validates_presence_of :name

	has_many :attendees
	has_one :location

	belongs_to :category
end
