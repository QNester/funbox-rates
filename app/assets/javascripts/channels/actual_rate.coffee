$(document).ready ->
  document.addEventListener "turbolinks:load", ->
    App.actual_rate = App.cable.subscriptions.create "ActualRateChannel",
      connected: ->
        console.log 'connecte to rates channel'

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        console.log("Notified about new rate: " + data["rate"] + ", from: " + data["from"] + ". Time: " + new Date)
        $('#current-rate').text(data["rate"] + "₽")
