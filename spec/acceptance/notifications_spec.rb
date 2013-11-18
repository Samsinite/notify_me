require 'spec_helper'

describe "Adding and removing notifications" do
	let(:user) { User.create(username: "Test") }
	let(:message_notification) { NotifyMe::Notification.create(message: "This is a test msg")}

	it "stores a new notifications" do
		user.notifications << message_notification

		user.notifications.reload.should == [message_notification]
	end
	
	it "removes existing notifications" do
		user.notifications << message_notification
		user.notifications.delete message_notification

		user.notifications.reload.should == []
	end
end