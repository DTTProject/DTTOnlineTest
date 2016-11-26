$(document).on('turbolinks:load', function(){
  $('.admin_response_email').on('click', function(){
    var feedback_id =  $(this).attr('id');
    $.ajax({
      url: '/admin/feedbacks/' + feedback_id,
      method: 'PATCH',
      dataType: 'JSON',
      data: {id: feedback_id},
      success: function(result){
        $('.feedback_' + result.id).addClass('inactive');
        $('.feedback_' + result.id).find('td:nth-child(5)').attr('class', 'text-success');
        $('.feedback_' + result.id).find('td:nth-child(5)').html('responsed');
      }
    })
  });
})
