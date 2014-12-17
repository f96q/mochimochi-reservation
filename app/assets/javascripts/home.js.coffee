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
        errors: []
      methods:
        switchStatus: (status) ->
          @errors = []
          @status = status
        clear: ->
          @status = 'form'
          @motimotiVol1Count = null
          @name = null
          @email = null
          @content = null
        postContact: ->
          $.ajax(
            method: 'post'
            url: '/api/contacts'
            data:
              contact:
                name: @name
                email: @email
                content: @content
                motimoti_vol1_count: @motimotiVol1Count
          ).done((data) =>
            @switchStatus('completion')
          ).fail((data) =>
            @errors = data.responseJSON.errors
          )