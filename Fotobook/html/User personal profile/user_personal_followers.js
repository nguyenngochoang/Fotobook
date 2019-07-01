$(document).ready(function(){
  $(".following-btn").click(function(){
      var text =$(this).text()
      if(text=="Following"){
        $(this).text("+ Follow")
        $(this).css("backgroundImage","")
        $(this).css("backgroundColor","#ffffff")
      }
      else{
        $(this).text("Following")
        $(this).css("backgroundImage","linear-gradient(to right, #fe8c00 51%, #f83600 100%)")
        $(this).css("color","white")
      }
  })
})