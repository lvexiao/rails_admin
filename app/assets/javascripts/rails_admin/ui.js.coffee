$ = jQuery

$("#list input.toggle").live "click", ->
  $("#list [name='bulk_ids[]']").attr "checked", $(this).is(":checked")

$('.pjax').live 'click', (event) ->
  if event.which > 1 || event.metaKey || event.ctrlKey
    return
  else if $.support.pjax
    event.preventDefault()
    $.pjax
      container: $(this).data('pjax-container') || '[data-pjax-container]'
      url: $(this).data('href') || $(this).attr('href')
      timeout: 2000
  else if $(this).data('href') # not a native #href, need some help
    window.location = $(this).data('href')

$('.pjax-form').live 'submit', (event) ->
  if $.support.pjax
    event.preventDefault()
    $.pjax
      container: $(this).data('pjax-container') || '[data-pjax-container]'
      url: this.action + (if (this.action.indexOf('?') != -1) then '&' else '?') + $(this).serialize()
      timeout: 2000

$(document)
  .on 'pjax:start', ->
    $('#loading').show()
  .on 'pjax:end', ->
    $('#loading').hide()

$('[data-target]').live 'click', ->
  if !$(this).hasClass('disabled')
    if $(this).has('i.icon-chevron-down').length
      $(this).removeClass('active').children('i').toggleClass('icon-chevron-down icon-chevron-right')
      $($(this).data('target')).select(':visible').hide('slow')
    else
      if $(this).has('i.icon-chevron-right').length
        $(this).addClass('active').children('i').toggleClass('icon-chevron-down icon-chevron-right')
        $($(this).data('target')).select(':hidden').show('slow')

$('.form-horizontal legend').live 'click', ->
  if $(this).has('i.icon-chevron-down').length
    $(this).siblings('.control-group:visible').hide('slow')
    $(this).children('i').toggleClass('icon-chevron-down icon-chevron-right')
  else
    if $(this).has('i.icon-chevron-right').length
      $(this).siblings('.control-group:hidden').show('slow')
      $(this).children('i').toggleClass('icon-chevron-down icon-chevron-right')

$(document).ready ->
  $(document).trigger('rails_admin.dom_ready')


$(document).live 'pjax:end', ->
  $(document).trigger('rails_admin.dom_ready')

$(document).live 'rails_admin.dom_ready', ->
  $('.animate-width-to').each ->
    length = $(this).data("animate-length")
    width = $(this).data("animate-width-to")
    $(this).animate(width: width, length, 'easeOutQuad')

  $('.form-horizontal legend').has('i.icon-chevron-right').each ->
    $(this).siblings('.control-group').hide()
