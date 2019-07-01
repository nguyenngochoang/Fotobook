$(document).ready(function(){

  $(".albumThumbnail").on('mouseover',function(){
      $(this).find(".photonums").stop().fadeIn(500);

  });
  $(".albumThumbnail").on('mouseleave',function(){
    $(this).find(".photonums").stop().fadeOut(500);

});

})