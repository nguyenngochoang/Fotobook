$(document).ready(function () {

    $(".hidethis").hide();


    //heart animation for love bttuon
    $(".HeartAnimation").click(function(e) {
        $(this).toggleClass("animate");
        preventDefault();


    });


    //end of heart animation


    // auto fade navbar
    var lastScrollTop = 0;
    var $navbar = $('.navbar');

    $(window).scroll(function (event) {
        var st = $(this).scrollTop();

        if (st > lastScrollTop) { // scroll down
            $navbar.fadeOut()
        } else { // scroll up
            $navbar.fadeIn()
        }
        lastScrollTop = st;
    });

    //end of auto fade navbar

    // navigations from this photo to another
    var index;
    var backgroundUrl;
    arr= []; //array to load all images of feeds
    $(".innerImg").each(function(){
        arr.push($(this).attr("src"));
    });

    $(".img").on("click", function(){
        jQuery.noConflict()
        backgroundUrl = $(this).children("img").attr("src");
        backgroundUrl = backgroundUrl.replace('url(','').replace(')','').replace(/\"/gi, "");
        $("#modal-body-image").attr("src",backgroundUrl);
        var text = $(this).next().find(".row-text").children("p").text();
        var title =  $(this).next().find(".row-text").children("h5").text();
        $(".modal-title").text(title);
        $(".modal-footer > p").text(text);
        jQuery('.modal').modal("toggle");
        index = arr.indexOf(backgroundUrl)

    });

    $(".next").on("click",function(){
        if(index<arr.length-1){
            index=index+1;
            backgroundUrl = arr[index];
            $("#modal-body-image").attr("src",backgroundUrl);
            var $selectthis =$("[src="+"'"+backgroundUrl+"'"+"]").parent().next();
            var text= $selectthis.find(".row-text").children("p").text();
            var title = $selectthis.find(".row-text").children("h5").text();
            $(".modal-title").text(title);
            $(".modal-footer > p").text(text);
        }

    });


    $(".prev").on("click",function(){
        if(index>0){
            index=index-1;
            backgroundUrl = arr[index];
            $("#modal-body-image").attr("src",backgroundUrl);
            var $selectthis =$("[src="+"'"+backgroundUrl+"'"+"]").parent().next();
            var text= $selectthis.find(".row-text").children("p").text();
            var title = $selectthis.find(".row-text").children("h5").text();
            $(".modal-title").text(title);
            $(".modal-footer > p").text(text);
        }

    });

    // end of navigations from this photo to another
    var $thisdiv = $(".hidethis:first");
    $(window).scroll(function() {
        if($(window).scrollTop() == $(document).height() - $(window).height()){
            $thisdiv.show();
            $thisdiv=$thisdiv.next();


        }
    });

    $(".follow-button").on("click",function(){
        if($(this).text()=="+ Follow"){
            $(this).text("Following");
            $(this).css("backgroundImage","linear-gradient(to right, #fe8c00 51%, #f83600 100%)");
            preventDefault();
        }
        else{
            $(this).text("+ Follow");
            $(this).css("backgroundImage","");
            $(this).css("backgroundColor","#ffffff");
            preventDefault();

        }
    })
});