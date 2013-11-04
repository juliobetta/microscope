Template.postPage.helpers({
  currentPost: ->
    return Posts.findOne(Session.get('currentPostId'))
})