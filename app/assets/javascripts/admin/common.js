$(document).on('turbolinks:load', function(){
  $('#all_users_table').dataTable();
  $('#questions_contributed').dataTable();
  $('.dataTables_length').html('');
  $('.dataTables_info').remove();
  $('.dataTables_paginate').remove();
})
