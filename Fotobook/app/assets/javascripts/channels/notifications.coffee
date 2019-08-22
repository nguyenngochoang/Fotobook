App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    console.log("c")
    # Called when the subscription is ready for use on the server

  disconnected: ->
    console.log("d")
    # Called when the subscription has been terminated by the server

  received: (data) ->
    console.log("r")
    $('.dropdown-menu').prepend "#{data.notification}"
    $('.noti-count').text data.counter
    # Called when there's incoming data on the websocket for this channel
