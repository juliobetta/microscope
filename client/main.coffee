@newPostsHandle  = Meteor.subscribeWithPagination 'newPosts',  10
@bestPostsHandle = Meteor.subscribeWithPagination 'bestPosts', 10

Meteor.subscribe 'notifications'

Deps.autorun(->
  Meteor.subscribe('singlePost', Session.get('currentPostId'))
  Meteor.subscribe('comments',   Session.get('currentPostId'))
)