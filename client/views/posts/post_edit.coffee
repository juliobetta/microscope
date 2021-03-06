Template.postEdit.helpers({
  post: ->
    Posts.findOne(Session.get('currentPostId'))
})

Template.postEdit.events({
  'submit form': (e) ->
    e.preventDefault()

    $form         = $(e.target)
    currentPostId = Session.get('currentPostId')

    postProperties = {
      url: $form.find('[name=url]').val(),
      title: $form.find('[name=title]').val()
    }

    Posts.update(currentPostId, {$set: postProperties}, (error) ->
      if error
        Errors.throw(error.reason)
      else
        Meteor.Router.to('postPage', currentPostId)
    )
  ,

  'click .delete': (e) ->
    e.preventDefault()

    if confirm('Delete this post?')
      currentPostId = Session.get('currentPostId')
      Posts.remove(currentPostId)
      Meteor.Router.to('postsList')
})