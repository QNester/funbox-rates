$(document).ready ->
  document.addEventListener "turbolinks:load", ->
    App.actual_rate = App.cable.subscriptions.create "ActualRateChannel",
      connected: ->

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        $('#current-rate').text(data["rate"] + "₽")
