$(document).on('turbolinks:load', function(){
  $('form').on('click', '.add_fields', function(event){
    event.preventDefault();
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
  });
  $('form').on('click', '.remove_fields', function(event){
    $(this).prev('input[type=hidden]').val(true)
    $(this).parent().parent().fadeOut();
  });
});
// $(document).on('turbolinks:load', function(){
// $('[data-form-prepend]').click( function(e) {
//   e.preventDefault();
//   var obj = $( $(this).attr('data-form-prepend') );
//   obj.find('input, select, textarea').each( function() {
//     $(this).attr( 'name', function() {
//       return $(this).attr('name').replace( 'new_record', (new Date()).getTime() );
//     });
//   });
//   obj.insertBefore( this );
//   return false;
// });
// });
