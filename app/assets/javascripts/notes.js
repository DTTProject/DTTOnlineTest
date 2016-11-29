$(document).on('turbolinks:load', function(){
  $('body').on('submit', '#new_note', function(e){
    e.preventDefault();
    var data = $(this).serialize();
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'JSON',
      data: data,
      cache: false,
      success: function(result){
        $('.list_notes').append('<li>'+result.content+'</li>').slideDown("fast");
        $('.pop_new_note').popover('hide');
      },
      error: function(xhr){
        errors = $.parseJSON(xhr.responseText);
        for(var key in errors) {
          toastr["error"](key + '   ' + errors[key]);
        }
        $('#new_note').find("button[type='submit']").removeAttr('disabled');
      }
    })
  });
})
