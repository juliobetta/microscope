Template.notifications.helpers({
  notifications: -> Notifications.find({userId: Meteor.userId(), read: false})
  # TODO: DRY up this code
  notificationCount: -> Notifications.find({userId: Meteor.userId(), read: false}).count()
})

Template.notifications.events({
  'click a': ->
    Notifications.update(this._id, {$set: {read: true}})
})