require 'rails/engine'

class NotifyMe::Engine < Rails::Engine
	engine_name :notify_me

	ActiveSupport.on_load :active_record do
		include NotifyMe::ActiveRecord
	end
end
