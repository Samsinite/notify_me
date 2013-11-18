class User < ActiveRecord::Base
	#include NotifyMe::ActiveRecord

	has_many_notifications
end