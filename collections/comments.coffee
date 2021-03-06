@Comments = new Meteor.Collection('comments')

Meteor.methods({
  insert_comment: (attributes)->
    user = Meteor.user()
    post = Posts.findOne(attributes.postId)

    throw new Meteor.Error(401, "You need to login to make comments") unless user
    throw new Meteor.Error(422, "Please, write something")            unless attributes.body
    throw new Meteor.Error(422, "You must comment on a post")         unless attributes.postId

    comment = _.extend(_.pick(attributes, 'postId', 'body'),{
      userId: user._id,
      author: user.emails[0].address.match(/([^@]+)/)[1], # only username
      submitted: new Date().getTime(),
    })

    comment._id = Comments.insert(comment)

    #increment commentsCount by 1
    Posts.update(comment.postId, {$inc: {commentsCount: 1}})

    createCommentNotification(comment)

    return comment._id
  ,
  delete_comment: (commentId)->
    comment = Comments.findOne(commentId)
    post    = Posts.findOne(comment.postId)

    throw new Meteor.Error(403, 'Access denied') unless Meteor.userId() is comment.userId

    Posts.update(comment.postId, {$inc: {commentsCount: -1}})

    # decrement commentsCount by -1
    Comments.remove(commentId)

})