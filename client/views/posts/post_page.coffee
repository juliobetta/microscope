Template.postPage.helpers({
  currentPost: ->
    return Posts.findOne(Session.get('currentPostId'))
  ,
  comments: ->
    return Comments.find({postId: @._id})
})