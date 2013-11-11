assert = require('assert')

suite('Posts', ->
  test('in the server', (done, server)->
    server.eval(->
      Posts.insert({title: 'Test Post'})
      docs = Posts.find().fetch()
      emit('docs', docs)
    )

    server.once('docs', (docs)->
      assert.equal(docs.length, 1)
      done()
    )
  )

  test('using both client and the server', (done, server, client)->
    server.eval(->
      Accounts.createUser({email: 'a@a.com', password: '123456'})
      emit('done')
    ).once('done', ->
      server.eval(observeCollection)
    )

    observeCollection = ->
      Posts.find().observe({
        added: (doc)-> emit('added', doc)
      })

    server.once('added', (doc)->
      assert.equal(doc.title, 'hello')
      done()
    )

    client.eval(->
      Meteor.loginWithPassword('a@a.com', '123456', ->
        Posts.insert({title: 'hello', url: 'http://www.google.com'})
      )
    )
  )
)