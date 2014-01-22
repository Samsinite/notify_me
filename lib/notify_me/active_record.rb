require 'active_support/concern'

module NotifyMe::ActiveRecord
	extend ActiveSupport::Concern

	module ClassMethods
		def has_many_notifications
			has_many :notifications, :as => :notifyable, :class_name => 'NotifyMe::Notification'
			has_many :actions,       :class_name => 'NotifyMe::Action', :through => :notifications
		end
	end
end
