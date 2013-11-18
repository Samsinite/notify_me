class NotifyMe::Action < ActiveRecord::Base
	self.table_name = "notify_me_actions"

	belongs_to :notification
	belongs_to :commandable, 			:polymorphic => true

	validates 	:notification, 			:presence => true
	validates 	:commandable_type, 		:presence => true
	validates 	:commandable_action,	:presence => true
	validate 	:validate_uniqness_of_unprocessed_identifiers
	validate 	:validate_pressence_of_action

	def validate_uniqness_of_unprocessed_identifiers
		if self.response_identifier != nil
			if NotifyMe::Action.where("response_identifier = ? AND has_been_processed = ?",
									  self.response_identifier, false).count > 0
				errors.add(:base, "The response_identifier is not unique among unprocessed actions")
			end
		end
	end

	def validate_pressence_of_action
		if self.commandable
			unless self.commandable.respond_to?(self.commandable_action)
				errors.add(:base, "The commandable action #{self.commandable_action} does not exist on the commandable instance")
			end
		else
			begin
				unless self.commandable_type.constantize.respond_to?(self.commandable_action)
					errors.add(:base, "The commandable action #{self.commandable_action} does not exist on the commandable_type constant")
				end
			rescue NameError
				errors.add(:base, "The commandable_type does not refer to a valid constant")
			end
		end
	end

	def self.process_by_identifier(identifier, *args)
		action = self.where("response_identifier = ? AND has_been_processed = ?",
				   identifier, false).first

		if action
			{:action => action, :rval => action.run_action(*args)}
		else
			nil
		end
	end

	def run_action(*args)
		rval = self.commandable.send(self.commandable_action, self, *args)

		self.has_been_processed = true
		self.save!

		return rval
	end
end