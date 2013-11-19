class AddTimestamps < ActiveRecord::Migration
	def up
		add_column :notify_me_actions, :created_at, :datetime
		add_column :notify_me_actions, :updated_at, :datetime
		add_column :notify_me_notifications, :created_at, :datetime
		add_column :notify_me_notifications, :updated_at, :datetime
	end

	def down
		remove_column :notify_me_actions, :created_at
		remove_column :notify_me_actions, :updated_at
		remove_column :notify_me_notifications, :created_at
		remove_column :notify_me_notifications, :updated_at
	end
end