$(document).ready(function(){

  $(".usercard").on('mouseover',function(){
      $(this).find(".photonums").stop().fadeIn(500);

  });
  $(".usercard").on('mouseleave',function(){
    $(this).find(".photonums").stop().fadeOut(500);

});

})