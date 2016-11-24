window.initializeCourseDelete = function () {
  $('a.course-delete-button').click (function(e){
    e.preventDefault();
    e.stopPropagation();

    if(confirm("Are you sure?")){
        var block = $(this).closest(".course-block").get(0);
        $.post(this.href, {_method:'delete'}, null, "script");
        $(block).hide();
        return false;
    } else {
        //they clicked no.
        return false;
    }

  });
}