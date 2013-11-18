
### Notify Me
This is a gem that provides simple and generic notifications that can have 0
or more actions associated with them.

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