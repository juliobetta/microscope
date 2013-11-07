# ROUTES
# ===============================================================
Meteor.Router.add({
  '/': 'postsList',

  '/posts/:_id': {
    to: 'postPage',
    and: (id) ->
      Session.set('currentPostId', id)
  },

  '/submit': 'postSubmit',

  '/posts/:_id/edit': {
    to: 'postEdit',
    and: (id) ->
      Session.set('currentPostId', id)
  }
})

# FILTERS
# ===============================================================

Meteor.Router.filters({
  'requireLogin': (page) ->
    if Meteor.user()
      page
    else if Meteor.loggingIn()
      'loading'
    else
      'accessDenied'
})

Meteor.Router.filter('requireLogin', {only: 'postSubmit'})