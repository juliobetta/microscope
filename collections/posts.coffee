@Posts = new Meteor.Collection('posts')

Posts.allow({
  update: ownsDocument,
  remove: ownsDocument
})

Posts.deny({
  update: (userId, post, fieldNames) ->
    # may only edit the following two fields
    return _.without(fieldNames, 'url', 'title').length > 0
})

Meteor.methods({
  post: (postAttributes) ->
    user             = Meteor.user()
    postWithSameLink = Posts.findOne({url: postAttributes.url})

    # ensure the user is logged in
    unless user
      throw new Meteor.Error(401, "You need to login to post new stories")

    # ensure the post has a title
    unless postAttributes.title
      throw new Meteor.Error(422, "Please fill in a headline")

    # check that there are no previous posts with the same link
    if postAttributes.url and postWithSameLink
      throw new Meteor.Error(302, "This link has already been posted", postWithSameLink._id)

    # pick out the whitelisted keys
    post = _.extend(_.pick(postAttributes, 'url', 'title', 'message'), {
      userId: user._id,
      author: user.emails[0].address.match(/([^@]+)/)[1], # only username
      submitted: new Date().getTime(),
      commentsCount: 0
    })

    post._id = Posts.insert(post)

    return post
})