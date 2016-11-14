$(document).on('turbolinks:load', function(){
  $('.carousel-button').hover(function(){
    $(this).addClass('animated');
    $(this).addClass('bounce');
    $(this).addClass('infinite');
  }, function(){
    $(this).removeClass('infinite');
  });

  $('.nav-head .nav-item a').on('click',function(e){
    e.preventDefault();
    var targetId = e.currentTarget.id + 'Section';
    $('html body').animate({
      scrollTop: $('#' + targetId).offset().top
    }, 1000);
  });


})

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
