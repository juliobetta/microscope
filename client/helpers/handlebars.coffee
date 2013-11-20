Handlebars.registerHelper('pluralize', (n, thing)->
  if n is 1 then "1 #{thing}" else "#{n} #{thing}s"
)

Handlebars.registerHelper('gravatarUrl', ->
  user = Meteor.user()
  Gravatar.imageUrl(user.emails[0].address, {s: 30}) if user
)