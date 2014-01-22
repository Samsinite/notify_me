require 'spec_helper'

describe NotifyMe::Action do
	let(:user) { User.create(username: "Test") }
	let(:message_notification) { NotifyMe::Notification.create(message: "This is a test msg") }

	it "can belong to a notification" do
		action = NotifyMe::Action.new(:notification => message_notification,
		                              :commandable => user,
		                              :commandable_action => "view_notification")
		action.should be_valid
	end

	it "must belong to a notification" do
		action = NotifyMe::Action.new(:commandable => user,
                                  :commandable_action => "view_notification")
		action.should_not be_valid
	end

	it "can belong to a commandable instance" do
		action = NotifyMe::Action.new(:notification => message_notification,
		                              :commandable => user,
		                              :commandable_action => "view_notification")

		action.should be_valid
	end

	it "can belong to a commandable constant" do
		action = NotifyMe::Action.new(:notification => message_notification,
		                              :commandable_type => "User",
		                              :commandable_action => "do_something")

		action.should be_valid
	end

	it "must belong to a existing commandable instance or a commandable constant" do
		action = NotifyMe::Action.new(:notification => message_notification)

		action.should_not be_valid
	end

	it "if it belongs to a commandable instance, it must belong to an existing instance" do
		action = NotifyMe::Action.new(:notification => message_notification,
		                              :commandable_type => "User",
		                              :commandable_id => 2,
		                              :commandable_action => "view_notification")

		action.should_not be_valid
	end

	it "if it belongs to a valid commandable instance, it must be able to process the action" do
		action = NotifyMe::Action.new(:notification => message_notification,
		                              :commandable_type => "User",
		                              :commandable_id => 1,
		                              :commandable_action => "fail_please")

		action.should_not be_valid
	end

	it "if it belongs to a valid commandable constant, it must be able to process the action" do
		action = NotifyMe::Action.new(:notification => message_notification,
		                              :commandable_type => "User",
		                              :commandable_action => "fail_please")

		action.should_not be_valid
	end
end

describe "Adding and removing actions" do
	let(:user) { User.create(username: "Test") }
	let(:message_notification) { NotifyMe::Notification.create(:message => "This is a test msg") }

	it "stores new actions" do
		action = message_notification.actions.create(:notification => message_notification,
		                                             :commandable => user,
		                                             :commandable_action => "view_notification")

		message_notification.actions.reload.should == [action]
	end

	it "removes existing actions" do
		action = message_notification.actions.create(:notification => message_notification,
		                                             :commandable => user,
		                                             :commandable_action => "view_notification")
		message_notification.actions.delete action

		user.notifications.reload.should == []
	end
end

describe "Processing actions" do
	let(:user) { User.create(username: "Test") }
	let(:message_notification) { NotifyMe::Notification.create(:message => "This is a test msg") }

	it "runs instance actions" do
		action = message_notification.actions.create(:notification => message_notification,
		                                             :commandable => user,
		                                             :commandable_action => "view_notification")
		action.run_action

		message_notification.has_been_viewed.should be_true
	end

	it "marks ran instance actions as processed" do
		action = message_notification.actions.create(:notification => message_notification,
		                                             :commandable => user,
		                                             :commandable_action => "view_notification")
		action.run_action

		action.has_been_processed.should be_true
	end

	it "runs constant actions" do
		action = NotifyMe::Action.new(:notification => message_notification,
		                              :commandable_type => "User",
		                              :commandable_action => "do_something")

		action.run_action.should eq("I ran successfully :)")
	end

	it "marks ran constant actions as processed" do
		action = NotifyMe::Action.new(:notification => message_notification,
		                              :commandable_type => "User",
		                              :commandable_action => "do_something")
		action.run_action

		action.has_been_processed.should be_true
	end
end