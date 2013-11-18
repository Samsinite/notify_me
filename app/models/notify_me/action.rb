class NotifyMe::Action < ActiveRecord::Base
	self.table_name = "notify_me_actions"

	belongs_to :notification
	belongs_to :commandable, 		:polymorphic => true

	validates :notification, 		:presence => true
	validates :commandable, 		:presence => true
	validates :commandable_action	:presence => true

	def run_action(*args)
		self.commandable.send(self.commandable_action, self, *args)

		self.has_been_processed = true
		self.save!
	end
end