# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#

$ ->
  $(".best_in_place").best_in_place()

  $(".trigger").click ->
    $(@).closest('.assign').find(".character-select").addClass 'reveal-select'

  $(".name").hover ->
    return if $(@).hasClass 'void'
    $(@).children(".empty").each ->
      $(@).addClass 'reveal'
  , ->
    $(@).children(".empty").each ->
      $(@).removeClass 'reveal'

  $('.best_in_place').bind "ajax:success", (data) ->
    if $(@).data('bip-value') == ""
      $(@).parent(".name-element").addClass("empty")
    else
      $(@).parent(".name-element").removeClass("empty")
      $(@).parent(".name-element").removeClass("reveal")

  $('.best_in_place').on 'focus', 'input', ->
    $(@).closest(".name-element").removeClass("empty")
    $(@).closest(".name-element").removeClass("reveal")

  $('.best_in_place').on 'blur', 'input', ->
    if $(@).val() == ""
      $(@).closest(".name-element").addClass("empty")
