class NotifyMe::Action < ActiveRecord::Base
	belongs_to :notification
	belongs_to :commandable, 		:polymorphic => true

	validates :notification, 		:presence => true
	validates :commandable, 		:presence => true
	validates :commandable_action	:presence => true
end