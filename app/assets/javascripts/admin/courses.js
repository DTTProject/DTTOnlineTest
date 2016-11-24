window.initializeCourseDelete = function () {
  $('a.course-delete-button').click (function(e){
    e.preventDefault();
    e.stopPropagation();

    if(confirm("Are you sure?")){
        var block = $(this).closest(".course-block").get(0);
        $.post(this.href, {_method:'delete'}, null, "script");
        $(block).hide();
        toastr["success"]("Course deleted successfully!!!")
        return false;
    } else {
        //they clicked no.
        return false;
    }

  });
}

$(document).on('turbolinks:load', function(){
  $('#modal-edit-course').on('submit', '.edit_course', function(e){
    e.preventDefault();
    var data =  new FormData( this );
    var url  =  $(this).attr('action');
    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'JSON',
      data: data,
      cache: false,
      processData: false,
      contentType: false,
      success: function(result){
        toastr['success']('Course edited successfully !');
        $('#modal-edit-course').modal('hide');
        location.reload();
      },
      error: function(xhr){
        errors = $.parseJSON(xhr.responseText);
        for(var key in errors) {
          toastr["error"](key + '   ' + errors[key]);
        }
        $('#new_course').find("button[type='submit']").removeAttr('disabled');
      }
    })
  });

  $('#new_course').on('submit', function(e){
    e.preventDefault();
    var data =  new FormData( this );
    var url  =  $(this).attr('action');
    $.ajax({
      url: url,
      method: 'POST',
      dataType: 'JSON',
      data: data,
      cache: false,
      processData: false,
      contentType: false,
      success: function(result){
        toastr['success']('Course created successfully !');
        $('#modal-new-course').modal('hide');
        location.reload();
      },
      error: function(xhr){
        errors = $.parseJSON(xhr.responseText);
        for(var key in errors) {
          toastr["error"](key + '   ' + errors[key]);
        }
        $('#new_course').find("button[type='submit']").removeAttr('disabled');
      }
    })
  });
})
