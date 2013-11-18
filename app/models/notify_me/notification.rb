class NotifyMe::Notification < ActiveRecord::Base
	self.table_name = "notify_me_notifications"

	has_many :actions, :class_name => 'NotifyMe::Action'
	belongs_to :notifyable, :polymorphic => true

	validates :message, :presence => true
end