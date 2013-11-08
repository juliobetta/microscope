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
        # display the error to the user
        throwError(error.reason)

        if error.error is 302
          # if the error is that the post already exists, take us there
          Meteor.Router.to('postPage', error.details)

      else
        Meteor.Router.to('postPage', post)
    )
})