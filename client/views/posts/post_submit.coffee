Template.postSubmit.events({
  'submit form': (e) ->
    e.preventDefault()

    $form = $(e.target)

    postAttributes = {
      url:     $form.find('[name=url]').val(),
      title:   $form.find('[name=title]').val(),
      message: $form.find('[name=message]').val()
    }

    # call method post on collections/posts.coffee, for security reason
    Meteor.call('post', postAttributes, (error, post) ->
      if error
        alert(error.reason)
      else
        Meteor.Router.to('postPage', post)
    )
})