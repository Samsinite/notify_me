[![Gem Version](https://badge.fury.io/rb/notify_me.png)](http://badge.fury.io/rb/notify_me) [![Code Climate](https://codeclimate.com/github/Samsinite/notify_me.png)](https://codeclimate.com/github/Samsinite/notify_me) [![Build Status](https://travis-ci.org/Samsinite/notify_me.png?branch=master)](https://travis-ci.org/Samsinite/notify_me)
# Notify Me
This is a gem that provides simple and generic notifications that can have 0
or more actions associated with them.

## Installation:

Add to Gemfile
```
gem 'notify_me', '0.0.4'
```
Now install and run your migrations
```
rake notify_me:install:migrations
rake db:migrate
```

## Usage:
``` ruby
    class User < ActiveRecord::Base
        has_many_notifications
        ...
    end
    
    class Task < ActiveRecord::Base
        ...
    end
    
    class TaskSwap < ActiveRecord::Base
        belongs_to :from, class_name: "User"
        belongs_to :to,     class_name: "User"
        belongs_to :task
    
        def accept_swap(action)
            ...
        end
    
        def reject_swap(action)
            ...
        end
    end
```
    
A user wants to request a task swap

``` ruby
    swap_task = TaskSwap.create(...)
    notification = NotifyMe::Notification.create(message: "John Doe would like to swap tasks with you")
    user.notifications << notification
    
    notification.actions.create(notification: notification, commandable: swap_task, commandable_action: "accept_swap", name: "Accept")
    notification.actions.create(notification: notification, commandable: swap_task, commandable_action: "reject_swap", name: "Reject")
```

Likely in some controller somewhere

``` ruby
    action = Action.find(params[:id])
    action.run_action() # if this was the action created above, this would call swap_task.accept_swap(action)
```
