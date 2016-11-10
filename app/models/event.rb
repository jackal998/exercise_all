class Event < ApplicationRecord

	validates_presence_of :name

	has_many :event_groupships
	has_many :groups, :through => :event_groupships

	has_many :attendees
	has_one :location

	belongs_to :category

	accepts_nested_attributes_for :location, :allow_destroy => true, :reject_if => :all_blank

end
