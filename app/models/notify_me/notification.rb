class NotifyMe::Notification < ActiveRecord::Base
	has_many :actions, :class_name => 'NotifyMe::Action'
	belongs_to :notifyable, :polymorphic => true

	validates :message, :presence => true
end