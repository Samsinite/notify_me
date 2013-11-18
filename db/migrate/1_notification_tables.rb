class NotificationTables < ActiveRecord::Migration
	def up
		create_table :notify_me_notifications do |t|
			t.integer 	:notifyable_id
			t.string 	:notifyable_type

			t.string 	:message
			t.string	:message_details
			t.boolean	:has_been_viewed, :required => true, :default => false
			t.string	:categories
		end

		add_index :notify_me_notifications, [:notifyable_id, :notifyable_type],
			:name => 'index_notifications_on_note_id_and_note_type'
		add_index :notify_me_notifications, [:notifyable_id, :notifyable_type, :categories],
			:name => 'index_notifications_on_note_id_and_note_type_and_categories'

		create_table :notify_me_actions do |t|
			t.integer 	:notification_id
			t.integer	:commandable_id
			t.string	:commandable_type
			t.string	:commandable_action
			t.string 	:response_identifier
			t.boolean	:has_been_processed, :required => true, :default => false
		end

		add_index :notify_me_actions, :notification_id
		add_index :notify_me_actions, :response_identifier
		add_index :notify_me_actions, [:notification_id, :response_identifier],
			:name => 'index_notifications_on_note_id_and_resp_ident'
		add_index :notify_me_actions, [:commandable_id, :commandable_type, :notification_id],
			:name => "index_actions_on_comm_id_and_comm_type_and_note_id"
		add_index :notify_me_actions, [:commandable_id, :commandable_type, :response_identifier],
			:name => "index_actions_on_comm_id_and_comm_type_and_resp_ident"
		add_index :notify_me_actions, [:commandable_id, :commandable_type, :notification_id, :response_identifier],
			:unique => true, :name => 'unique_actions'
	end

	def down
		drop_table :notify_me_notifications
		drop_table :notify_me_actions
	end
end