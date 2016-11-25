$(document).on('turbolinks:load', function(){
  //Delete question
  $('#modal_delete_user').on('show.bs.modal', function (event) {
    var user_id = $(event.relatedTarget).attr('id');
    // console.log(user_id);
    var modal =  $(this);
    modal.find('button.confirmed_delete_user').attr('user_id', user_id)
  })
  $('.confirmed_delete_user').on('click', function(){
    $('#model_delete_user').modal('hide');
    var user_id =  parseInt($(this).attr('user_id'));
    $.ajax({
      url: '/admin/users/' + user_id,
      method: 'DELETE',
      dataType: 'JSON',
      data: {id: user_id},
      success: function(result){
        toastr['success']("User blocked successfully");
        $('.user_' + result.id).parent().parent().addClass('inactive');
        $('#modal_delete_user').modal('hide');
      }
    })
  });

  $('.restore_user').on('click', function(){
    var user_id = $(this).attr('id');
    $.ajax({
      url: '/admin/users/' + user_id,
      method: 'PATCH',
      dataType: 'JSON',
      data: {id: user_id},
      cache: false,
      success: function(result){
        toastr['success']("User restored successfully");
        $('.user_' + result.id).parent().parent().removeClass('inactive');
        $('.user_' + result.id).prev().attr('data-target', '#modal_delete_user');
      }
    })
  })
})
