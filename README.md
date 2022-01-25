# notifications
Apple Push Notifications Demo

You can badge your app icon to indicate a count of unread notifications.

Use a badge only to show people how many unread notifications they have. Don’t use a badge to convey other types of numeric information, such as weather-related data, dates and times, stock prices, or game scores.

Don’t use a badge to communicate important information. People can turn off badging for your app, so if you rely on badging to communicate important information, you run the risk of people missing it.

Keep badges up to date. Update your app’s badge as soon as people view the corresponding information. You don’t want people to think there’s new information available, only to find that they’ve already seen it. Note that reducing a badge’s count to zero removes all related notifications from Notification Center.

If your app’s server-based content changes infrequently or at irregular intervals, you can use background notifications to notify your app when new content becomes available. A background notification is a remote notification that doesn’t display an alert, play a sound, or badge your app’s icon. It wakes your app in the background and gives it time to initiate downloads from your server and update its content.

The system treats background notifications as low priority: you can use them to refresh your app’s content, but the system doesn’t guarantee their delivery. In addition, the system may throttle the delivery of background notifications if the total number becomes excessive. The number of background notifications allowed by the system depends on current conditions, but don’t try to send more than two or three per hour.

To send a background notification, create a remote notification with an aps dictionary that includes only the content-available key, as shown in Listing 1. You may include custom keys in the payload, but the aps dictionary must not contain any keys that would trigger user interactions.

When a device receives a background notification, the system may hold and delay the delivery of the notification, which can have the following side effects:
* When the system receives a new background notification, it discards the older notification and only holds the newest one.
* If something force quits or kills the app, the system discards the held notification.
* If the user launches the app, the system immediately delivers the held notification.

