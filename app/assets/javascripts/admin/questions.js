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
  })
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
