# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  document.addEventListener "turbolinks:load", ->
    if window.location.pathname == '/'
      if window.Interval
        window.clearInterval(window.Interval)
      window.Interval = setInterval () ->
        console.log 'interval'
        $.getJSON('/rate.json', (data) ->
          $('#current-rate').text(data["rate"] + "₽")
        )
      , 6000
    else
      if window.Interval
        window.clearInterval(window.Interval)
