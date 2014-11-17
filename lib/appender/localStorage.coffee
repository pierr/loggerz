InterfaceApender = require './interface'
guid = require '../util/guid'
STORAGE_KEY = 'logger/'
INDEX_KEY = STORAGE_KEY + 'index'
###
 Interface for the Appender with all the methods to implement in order ot be an Interface.
###
module.exports = class LocalStorageAppender extends InterfaceApender
  _addToIndex:(id)->
    index = @_getIndex()
    index.push(id)
    localStorage.setItem(INDEX_KEY,JSON.stringify(index))
  ###
    Get the current index
  ###
  _getIndex:->
    return JSON.parse(localStorage.getItem(INDEX_KEY) or "[]")
  ###
    Add a message into the localStorage.
    @param {Message} message - The message to add.
  ###
  _addItem:(message)->
    uid = guid()
    key = "#{STORAGE_KEY}#{uid}"
    localStorage.setItem(key, JSON.stringify(message.toJSON()))
    @_addToIndex(uid)
  _getAllItems:->
    msgs = []
    for idx in @_getIndex()
      msgs.push(
        JSON.parse(
          localStorage.getItem("#{STORAGE_KEY}#{idx}")
        )
      )
    return msgs
  ###
    Log the message given as argument.
  ###
  log: (message) ->
    #console.log('log called')
    super(message)
    @_addItem(message)
  ###
    Clear all the messages.
  ###
  clear: ->
    for idx in @_getIndex()
      localStorage.removeItem("#{STORAGE_KEY}#{idx}")
    localStorage.removeItem(INDEX_KEY)
  ###
    Display all the messages into the appender.
  ###
  display:->
    msgs = @_getAllItems()
    if msgs? and msgs.length > 0
      console.table(msgs)
    else 
      console.log("No messages are registered.")