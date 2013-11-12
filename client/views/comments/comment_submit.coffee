Template.commentSubmit.events({
  'submit form': (e, template)->
    e.preventDefault()

    $form = $(e.target)
    $body = $form.find('[name=body]')

    comment = {
      body: $body.val(),
      postId: template.data._id
    }

    Meteor.call('insert_comment', comment, (error, commentId)->
      if error
        Errors.throw(error.reason)
      else
        $body.val('')
    )
})