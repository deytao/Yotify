# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
    $('#notify_them').on 'click', (e) ->
        e.preventDefault();
        $('#notifier').modal({
            onApprove: () ->
                $('#notify_form').submit();
                return false;
        }).modal('show');
