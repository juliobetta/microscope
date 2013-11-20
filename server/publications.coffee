Meteor.publish 'newPosts',   (limit)-> Posts.find({}, {sort: {submitted: -1}, limit: limit})
Meteor.publish 'bestPosts',  (limit)-> Posts.find({}, {sort: {votes: -1, submitted: -1}, limit: limit})
Meteor.publish 'singlePost', (id)   -> id and Posts.find(id)

Meteor.publish 'comments', (postId)-> Comments.find({postId: postId})

Meteor.publish 'notifications', -> Notifications.find({userId: this.userId})