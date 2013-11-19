require 'active_support/configurable'

module NotifyMe
	def self.configure(&block)
		yield @config ||= NotifyMe::Configuration.new
	end

	def self.config
		@config
	end

	class Configuration
		include ActiveSupport::Configurable
	end
end
