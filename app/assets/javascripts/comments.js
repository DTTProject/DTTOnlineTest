$(document).on('turbolinks:load', function(){
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var url = $(this).attr('action');
    var data = $(this).serialize();
    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'JSON',
      data: data,
      cache: false,
      success: function(result){
        $('#modal_comment').modal('hide');
        toastr["success"]('Awesome. Thanks for your comment!');
      },
      error: function(xhr){
        errors = $.parseJSON(xhr.responseText);
        for(var key in errors) {
          toastr["error"](key + '   ' + errors[key]);
        }
        $('#new_comment').find("button[type='submit']").removeAttr('disabled');
      }
    })
  })
});
