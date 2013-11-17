Template.postsList.helpers({
  posts:          -> Posts.find({}, {sort: {submitted: -1}, limit: postHandle.limit()}),
  postsReady:     -> postHandle.ready(),
  allPostsLoaded: -> postHandle.ready() and Posts.find().count() < postHandle.loaded()
})

Template.postsList.events({
  'click .load-more': (e) ->
    e.preventDefault()
    postHandle.loadNextPage()
})