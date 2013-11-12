@Comments = new Meteor.Collection('comments')

Comments.allow({remove: ownsDocument})

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

    #increment commentsCount by 1
    Posts.update(comment.postId, {$inc: {commentsCount: 1}})

    Comments.insert(comment)
  ,
  delete_comment: (commentId)->
    comment = Comments.findOne(commentId)

    throw new Meteor.Error(403, 'Access denied') unless Meteor.userId() is comment.userId

    # decrement commentsCount by -1
    Posts.update(comment.postId, {$inc: {commentsCount: -1}})
    Comments.remove(commentId)
})