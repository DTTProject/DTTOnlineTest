
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
  $('.home_link').on('click', function(){
    $('html body').animate({
      scrollTop: 0
    }, 1000);
  });
  $('.nav-head .nav-item > a.home_page_link').on('click',function(e){
    e.preventDefault();
    var targetId = e.currentTarget.id + 'Section';
    $('html body').animate({
      scrollTop: $('#' + targetId).offset().top
    }, 1000);
  });

  $('.go_to_test').on('click',function(e){
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

  //Margin nav fixed
  var contentPlacement = $('#header_fixed').position().top + $('#header_fixed').height();
  $('#content').css('margin-top',contentPlacement);

  //blank label
  $('.questions_answers').find('.answers').find('label').html(' ');
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
