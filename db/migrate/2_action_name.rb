class ActionName < ActiveRecord::Migration
	def up
		add_column :notify_me_actions, :name, :string
	end

	def down
		remove_column :notify_me_actions, :name
	end
end