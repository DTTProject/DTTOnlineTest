
$(document).on('turbolinks:load', function(){
  //Select materialize initial
    $('.mdb-select').material_select();
  //Create animation
  $('.carousel-button').hover(function(){
    $(this).addClass('animated');
    $(this).addClass('bounce');
    $(this).addClass('infinite');
  }, function(){
    $(this).removeClass('infinite');
  });

  //Scroll page
  $('.nav-head .nav-item a').on('click',function(e){
    e.preventDefault();
    var targetId = e.currentTarget.id + 'Section';
    $('html body').animate({
      scrollTop: $('#' + targetId).offset().top
    }, 1000);
  });


  //Switch suggestion
  $('.switch_suggestion').on('click', function(){
    $('.suggestion_area').toggleClass('hidden-xs-up');
  })

  // Tooltips Initialization
  $(function () {
    $('[data-toggle="tooltip"]').tooltip()
  })
});

//Function handle scroll
function scrollNavHandle()
{
  var carouselHeight =  document.getElementById('carousel-example-1').offsetHeight;
  var navBar =  document.getElementsByClass('navbar');
  if(window.pageYOffset > carouselHeight)
  {
    navBar.style.backgroundColor = "#4285F4";
  }else {
    navBar.style.backgroundColor = "transparent";
  }
}
