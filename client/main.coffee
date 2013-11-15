Meteor.subscribe 'posts'
Meteor.subscribe 'notifications'

Deps.autorun(->
  Meteor.subscribe('comments', Session.get('currentPostId'))
)

Template.header.helpers({
  gravatarUrl: ->
    if Meteor.user()
      Gravatar.imageUrl(Meteor.user().emails[0].address, {s: 30})
})