$(document).on('turbolinks:load', function(){
  $('#all_users_table').dataTable();
  $('#questions_contributed').dataTable();
  $('#admin_contribution_questions').dataTable();
  $('#admin_log_users').dataTable();
  $('#all_feedbacks_table').dataTable();
  $('.dataTables_length').html('');
  $('.dataTables_info').remove();
  $('.dataTables_paginate').hide();
  $('#admin_log_users_paginate').show();
})
