$(function() {
  $("#feedback").hide();
  if ( $("feedback").html() != "" )
{
  $("#feedback").delay(500).slideDown('slow', function() {
    $(this).delay(2500).slideUp('slow');
  });
}
});
