$(function() {
  $("#feedback").hide();
  if ( $("feedback").html() != "" )
{
  $("#feedback").delay(500).slideDown('slow', function() {
    $(this).delay(2500).slideUp('slow');
  });
}

$(document).ready(function(){
  $(".ajaxful-rating a")
  .bind("ajax:success", function(status, data, xhr) {
    $('#' + data.id + ' .show-value').css('width', data.width + '%');
    $('#' + data.id + ' .show-value').html('Votre note : ' + data.stars + ' sur ' + data.max);
  });
});

});

