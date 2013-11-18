class NotifyMe::Action < ActiveRecord::Base
	self.table_name = "notify_me_actions"
	
	belongs_to :notification
	belongs_to :commandable, 		:polymorphic => true

	validates :notification, 		:presence => true
	validates :commandable, 		:presence => true
	validates :commandable_action	:presence => true
end