Template.comment.helpers({
  submittedText: -> new Date(@.submitted).toString(),
  ownComment: -> @.userId is Meteor.userId()
})

Template.comment.events({
  'click .delete': (e, template)->
    e.preventDefault()

    if confirm('Delete this comment?')
      $("##{template.data._id}").fadeOut(->
        Meteor.call('delete_comment', template.data._id)
      )
})