Template.header.helpers({
  activeRouteClass: ->
    args = Array.prototype.slice.call(arguments, 0)

    # call pop to get rid of the hash added at the end by Handlebars.
    args.pop()

    active = _.any(args, (name)->
      location.pathname is Meteor.Router["#{name}Path"]()
    )

    # We're taking advantage of the boolean && string JavaScript pattern
    # where false && myString returns false, but true && myString returns myString.
    active and 'active'
})