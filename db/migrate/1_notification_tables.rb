class NotificationTables < ActiveRecord::Migration
	def up
		create_table :notifications do |t|
			t.integer 	:notifyable_id
			t.string 	:notifyable_type

			t.string 	:message
			t.string	:message_details
			t.boolean	:has_been_viewed, :required => true, :default => false
			t.string	:categories
		end

		add_index :notifications, [:notifyable_id, :notifyable_type]
		add_index :notifications, [:notifyable_id, :notifyable_type, :categories]

		create_table :actions do |t|
			t.integer 	:notification_id
			t.integer	:commandable_id
			t.string	:commandable_type
			t.string	:commandable_action
			t.string 	:response_identifier
			t.boolean	:has_been_processed, :required => true, :default => false
		end

		add_index :actions, :notification_id
		add_index :actions, :response_identifier
		add_index :actions, [:notification_id, :response_identifier]
		add_index :actions, [:commandable_id, :commandable_type, :notification_id]
		add_index :actions, [:commandable_id, :commandable_type, :response_identifier]
		add_index :actions, [:commandable_id, :commandable_type, :notification_id, :response_identifier],
			:unique => true, :name => 'unique_actions'
	end

	def down
		drop_table :notifications
		drop_table :actions
	end
end