Meteor.Router.add({
  '/': 'postsList',
  '/posts/:_id': {
    to: 'postPage',
    and: (id) ->
      Session.set('currentPostId', id)
  }
})