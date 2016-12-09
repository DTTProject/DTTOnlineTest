$(document).on("turbolinks:load", function(){
  $('.mask_as_read_button').on('click', function(e){
    e.preventDefault();
    var not_id =  $(this).data('id');
    $.ajax({
      url: '/notifications/' + not_id,
      type: 'PATCH',
      dataType: 'JSON',
      data: {id: not_id},
      success: function(e){
        $('.notification_' + e.id).find('.mask_as_read_button').hide();
        $('.notification_' + e.id).attr('class', 'read')
      }
    })
  })
})
