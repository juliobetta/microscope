Template.postItem.helpers({
  ownPost: -> this.userId == Meteor.userId()

  domain: ->
    a = document.createElement('a')
    a.href = @.url
    return a.hostname

  upvotedClass: ->
    userId = Meteor.userId()
    if userId and not _.include(this.upvoters, userId) then 'btn-primary upvotable' else 'disabled'
})

Template.postItem.events({
  'click .upvotable': (e)->
    e.preventDefault()
    Meteor.call('upvote', this._id)
})