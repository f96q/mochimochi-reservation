# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Vue.use @['vue-validator']

$ ->
  if $('.js-reservation')[0]
    new Vue
      el: '.js-reservation'
      data:
        status: 'form'
      methods:
        switchStatus: (status) ->
          @status = status
        clear: ->
          @status = 'form'
          @motimotiVol1Count = null
          @name = null
          @email = null
          @content = null