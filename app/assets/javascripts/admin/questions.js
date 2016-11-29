$(document).on('turbolinks:load', function(){
  $('body').on('click', '.answers_checkbox', function(){
    var checkbox =  this;
    console.log(checkbox);
    if(checkbox.checked) {
      $('.answers_checkbox').each(function(){
        if(checkbox != this){
          $(this).prop("checked", false);
        }
      })
    }
  });

  //Delete question
  $('#model_delete_question').on('show.bs.modal', function (event) {
    var question_id = $(event.relatedTarget).attr('id');
    var modal =  $(this);
    modal.find('button.confirmed_delete_question').attr('question_id', question_id)
  })
  $('.confirmed_delete_question').on('click', function(){
    $('#model_delete_question').modal('hide');
    var question_id =  parseInt($(this).attr('question_id'));
    $.ajax({
      url: '/admin/questions/' + question_id,
      method: 'DELETE',
      dataType: 'JSON',
      data: {id: question_id},
      success: function(result){
        if(result.warning){
          toastr['warning'](result.warning.message);
        }
        else {
          toastr['success']("Question deleted successfully");
          $('.question_' + result.id).parent().parent().remove();
        }
      }
    })
  });

  //Admin handle contributed questions
  $('.admin_handle').on('click', function(e){
    e.preventDefault();
    var status = $(this).attr('status');
    var question_id = $(this).attr('id');
    // var href = $(this).attr('href');
    $.ajax({
      url: '/admin/questions/' + question_id,
      method: 'PATCH',
      dataType: 'JSON',
      data: {question: {status: status, id: question_id}, id: question_id},
      success: function(result){
        toastr["success"]("Question updated successfully");
        if(result.status == 'accepted') {
          $('.question_' + result.id).removeClass('inactive');
          $('.question_' + result.id).find('td:nth-child(5)').attr('class', 'text-success');
          $('.question_' + result.id).find('td:nth-child(5)').html(result.status);
        }else {
          $('.question_' + result.id).addClass('inactive');
          $('.question_' + result.id).find('td:nth-child(5)').attr('class', 'text-danger');
          $('.question_' + result.id).find('td:nth-child(5)').html(result.status);
        }
        console.log(result);
      },
      error: function(err){
        // toastr[]
      }
    })
  });

  $('#question_course_id').on('change', function(){
    var course_id = $(this).val();
    $.ajax({
      url: '/admin/questions/load_weeks',
      method: 'POST',
      dataType: 'JSON',
      data: {course_id: course_id},
      success: function(result){
        $('.weeks_choosen').html(result.content);
      }
    })
  });
  //Quill editor add question
  $('#new_question').on('submit', function(e){
    e.preventDefault();
    var value = $('#editor-container').find('.ql-editor').html();
    $(this).find('#question_content').val(value);
    var value1 = $('#editor-container-1').find('.ql-editor').html();
    $(this).find('#question_suggestion').val(value1);
    var url = $(this).attr('action');
    var data =  $(this).serialize();
    $.ajax({
      url: url,
      dataType: 'JSON',
      method: 'POST',
      data: data,
      cache: false,
      success: function(result){
        if(result.id == 2 ) {

          window.location.replace('/admin/questions')
        }else {
          window.location.replace('/questions')
        }
      },
      error: function(xhr){
        errors = $.parseJSON(xhr.responseText).errors;
        for(var key in errors) {
          console.log(key + errors[key]);
          toastr["error"](key + ' ' + errors[key]);
        }
        $('#new_question').find("input[type='submit']").removeAttr('disabled');
      }
    })
  });
});

// $(document).ready(function(){
//   var toolbarOptions =  [
//     ['bold', 'italic', 'underline', 'strike'],
//     ['blockquote', 'code-block']
//   ];

//   var options = {
//     debug: 'info',
//     modules: {
//       toolbar: toolbarOptions
//     },
//     placeholder: 'Content ....',
//     readOnly: false,
//     theme: 'snow'
//   };
//   var editor = new Quill('#editor', options);
// })
