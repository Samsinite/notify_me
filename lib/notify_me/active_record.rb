module NotifyMe::ActiveRecord
	def self.include(base)
		base.extend NotifyMe::ActiveRecord::ClassMethods
	end

	module ClassMethods
		def has_many_notifications
			has_many :notifications, 	:as => :notifyable, :class_name => 'NotifyMe::Notification'
			has_many :actions, 			:class_name => 'NotifyMe::Action', :through => :notifications
		end
	end
end