$(document).on('turbolinks:load', function(){
  //Ajax sign up
  $('#new_user').on('submit', function(e){
    e.preventDefault();
    var data = $(this).serializeArray();
    var url =  $(this).attr('action');
    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'JSON',
      data: data,
      cache: false,
      success: function(result){
        toastr["success"]('Signed up successfully !!!');
        $('#modal-register').modal('hide');
        location.reload();
      },
      error: function(xhr){
        errors = $.parseJSON(xhr.responseText).errors;
        for(var key in errors) {
          console.log(key + errors[key]);
          toastr["error"](key + ' ' + errors[key]);
        }
        $('#new_user').find("input[type='submit']").removeAttr('disabled');
      }

    })
  })

  //Switch form login - signup
  $('.button_register_modal').on('click', function(){
    $('#modal-login').modal('hide');
    // alert(1);
  });
  $('.button_login_modal').on('click', function(){
    $('#modal-register').modal('hide');
  })

  //Login User
  $('.user_login_form').on('submit', function(e){
    e.preventDefault();
    var data = $(this).serializeArray();
    var url =  $(this).attr('action');
    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'JSON',
      data: data,
      cache: false,
      success: function(result){
        toastr["success"]('Signed in successfully !!!');
        $('#modal-login').modal('hide');
        location.reload();
      },
      error: function(xhr){
        toastr["error"](xhr.responseText);
        $('.user_login_form').find("input[type='submit']").removeAttr('disabled');
      }

    })
  })
})
