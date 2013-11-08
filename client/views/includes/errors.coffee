Template.errors.helpers({
  errors: ->
    Errors.find()
})

# The rendered callback triggers once our template has been rendered in the browser.
# Inside the callback, @ refers to the current template instance, and @.data
# lets us access the data of the object that is currently being rendered (in our case, an error).
Template.error.rendered = ->
  error = @.data
  Meteor.defer(->
    Errors.update(error._id, {$set: {seen: true}})
  )