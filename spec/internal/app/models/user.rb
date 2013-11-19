class User < ActiveRecord::Base
	has_many_notifications

	def view_notification(action)
		action.notification.has_been_viewed = true
		action.notification.save!

		true
	end

	def self.do_something(action)
		"I ran successfully :)"
	end
end