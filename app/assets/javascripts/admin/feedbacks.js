window.initializeFeedbackDelete = function () { 
  $('a.feedback-delete-button').click (function(e){ 
    e.preventDefault(); 
    e.stopPropagation(); 
 
    if(confirm("Are you sure?")){ 
        var block = $(this).closest(".feedback-block").get(0); 
        $.post(this.href, {_method:'delete'}, function() {
          toastr.info("Feedback has been successfully deleted");
        }, "script");
        
        $(block).hide();
        return false; 
    } else {
        //they clicked no.
        return false;
    }
  }); 
}
