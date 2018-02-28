(function($) {
  "use_strict";
  
  $(window).on('load', function() {
    $('#page-loader').fadeOut('fast', function() {
        $(this).remove();
    });

  });
  

  $(document).ready(function(){

      /**********************\
      // nav toggler
      /************************/
       $('.sm-nav-toggler').on('click', function(){
         $('#nav').toggleClass('nav-open');
       });


      /**********************\
      //typist init
      /************************/

      if (typeof Typist == "function") {
        new Typist(document.querySelector(".typelist-skill"), {
            letterInterval: 60,
            textInterval: 1000
        });
      }


      /**********************\
      //intro video popup 
      /************************/
        $('.btn-play-video').magnificPopup({
          disableOn: 700,
          type: 'iframe',
          mainClass: 'mfp-fade',
          removalDelay: 160,
          preloader: false,
          fixedContentPos: false
        });


      /**********************\
      // Awards slider Init
      /************************/
      $('.awards-slides').owlCarousel({
        responsiveClass:true,
        responsive : {
          0 : {
            items:1
          },
          480 : {
            items:2
          },    
          768 : {
              items:3
          }
      }
      });


      /**********************\
      // quote slider Init
      /************************/
      $('.quote-slides').owlCarousel({
        responsiveClass:true,
        autoplay:true,
        responsive : {
          0 : {
            items:1
          },
          767: {
            items:1
          },    
          991: {
              items:2
          }
      }
      });


    
      /**********************\
      // skill Progrss-bar
      /************************/
      $(".progress-bar").each(function(){
          each_bar_width = $(this).attr('aria-valuenow');
          $(this).css({
            width:each_bar_width + "%"
          });
          $(this).html('<span class="progress-tooltip" style="left:'+ each_bar_width +'%">' + each_bar_width + '%</span>');
      });



      /**********************\
      //Portfolio gallary
      /************************/
      $('.portfolio').magnificPopup({
        delegate: 'a.popup-img',
        type: 'image',
        closeOnContentClick: false,
        closeBtnInside: false,
        mainClass: 'mfp-with-zoom mfp-img-mobile',
        gallery: {
        enabled: true
        }
      });


      /**********************\
      // Portfolio image slider init
      /************************/
        $('.portfolio-slider').owlCarousel({
        singleItem: true,
        loop: true,
        nav: true,
        items: 1,
        pagination: false,
        dots:false,
        navSpeed:600,
        nav:true,
        navText:['<span class="lnr lnr-arrow-left"></span>', '<span class="lnr lnr-arrow-right"></span>']
      });



      /**********************\
      Post tabs
      /************************/
      $('.post-tab-list').on('click', 'a', function(e) {
          e.preventDefault();
        $('.post-tab-list a.active').removeClass('active');
          var tab = $(this).data('tab');
          $('.tab-content').removeClass('active');
          $('#' + tab).addClass('active');
          $(this).addClass('active');

      });


      /**********************\
      /// Scroll to top
      /************************/

      var doc_height = $(document).height();
      $(window).on('scroll', function() {
        if ($(this).scrollTop() > (doc_height - 1000)) {
            $('.scroll-top.active').removeClass('active');
            $('.scroll-top').addClass('active');
        } else {
            $('.scroll-top').removeClass('active');
        }
      });
      $('.scroll-top').on('click', function() {
          $("html, body").animate({
              scrollTop: 0
          }, 600);
          return false;
      });



      /**********************\
      // Fun fact count
      /************************/

      $('.fun-fact-count').countTo();  



      /**********************\
      // Equal height
      /************************/
      $(".equal-height").matchHeight();
    
    
    /// smooth scroll
    $('.scrolling').on('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 500);
        event.preventDefault();
    });
    
    
    /**********************\
    //portfolio isotope init
    /************************/
    
    $('.portfolio-filter').on('click', 'li', function(){
      var filterValue = $(this).attr('data-filter');
      $('.portfolio-filter > li.active').removeClass('active');
      $(this).addClass('active')
      $('.portfolio').isotope({
        filter: filterValue
      });
    });
    
    var $portfolio = $('.portfolio'); 
    $portfolio.imagesLoaded( function(){
      $portfolio.isotope({
        itemSelector : '.portfolio-item',
        layoutMode: 'fitRows'
      });
    });

    
    
    
  if($(window).width() > 767){
    var wow = new WOW(
    {       
      mobile:       false,      
    }
  );
  wow.init();

  }
    
    

  });
  
}(jQuery));


 
















