# Notify Me
This is a gem that provides simple and generic notifications that can have 0
or more actions associated with them.

[![Code Climate](https://codeclimate.com/repos/528be65b7e00a4785200fb08/badges/8e690d31fd37dcb6c9ea/gpa.png)](https://codeclimate.com/repos/528be65b7e00a4785200fb08/feed)

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
    swap_task = SwapTask.create(...)
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


## Notification
* belongs_to :notifyable
* has_many :actions
* message - String
* message_details - String
* categories - String

## Action
* belongs_to :notification
* belongs_to :commandable
    * can either be an instance
    * or a class (set the :commandable_type String to the class name -- I.E. "User")
* commandable_action - String
    * must either be
        * an action on the instance
        * or an action on the class
* response_identifier - String
    * not required, but if it is provided it must be unique
* has_been_processed - Boolean
    * set to true after the action is processed.
* name - String
    * say you want a name to display in a UI, use this field here
