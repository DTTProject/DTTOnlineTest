$(document).on("turbolinks:load", function(){
  $('#invite_challenge').on('show.bs.modal', function (event) {
    var test_id = $(event.relatedTarget).data('id');
    var modal =  $(this);
    modal.find('div.test_id').find('input').val(test_id);
  });
  $('#new_exam').on('submit', function(e){
    e.preventDefault();
    var data = $(this).serialize();
    var url =  $(this).attr('action');
    $.ajax({
      url: url,
      dataType: 'JSON',
      type: 'POST',
      data: data,
      cache: false,
      success: function(e){
        $('#invite_challenge').modal('hide');
        toastr["success"]("An email invite sent to each others");

      },
      error: function(xhr){
        toastr["error"]("Something went wrong");
      }

    })
  })
})
