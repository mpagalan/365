// (JQuery extension) this is for collapse/expand links
(function($) {
  $.fn.link_to_colex = function(selector, options) {
    var settings = $.extend($.fn.link_to_colex.default_options, options, {});
    $(this).addClass(settings.colex_class)
           .removeClass(settings.excol_class).each( function(i){
              $(this).click( function() {
                 $(selector).slideToggle(settings.toggle_speed);
                 $(this).toggleClass(settings.colex_class)
                        .toggleClass(settings.excol_class);
                 return false;
              });
           });
  };

  $.fn.link_to_colex.default_options = { excol_class: 'excol', colex_class: 'colex',  toggle_speed: 450 }
  
  // an extension to create remote form(s)
  $.fn.remote_form = function() {
    $(this).submit(function(){
      $.post($(this).attr("action"), $(this).serialize(), null, "script");
      return false;
    });
  };

  $.show_loader = function(){
    var settings = $.show_loader.defaults;
    var height = $(window).height();
    var width = $(window).width();
    $(settings.selector).css({'width': width, 'height': height}).show();
    $(window).resize( function(){
      $(settings.selector).css({'width': width, 'height': height});
    });
  };
  
  $.hide_loader = function(){
    var settings = $.show_loader.defaults;
    $(settings.selector).hide();
  };

  $.show_loader.defaults = {
      selector: "#main_overlay"
  }
})(jQuery);

// setup all jquery ajax request recognizable by rails
jQuery.ajaxSetup({
  'beforeSend':function(xhr){xhr.setRequestHeader('Accept','text/javascript')}
});

$().ajaxStart($.show_loader).ajaxStop($.hide_loader);

// window related events
$(window).load(function(){
  //$('#mainContainer').css('visibility', 'visible');
  $('#audioPlayer').show();
  //$.hide_loader();
});

function refigure() {
 var height = $(window).height();
 var width = $(window).width();

 $('div.fullimage img').css({'width': width , 'height': height });
 $('div.fullimage').css({'width': width , 'height': height });
 $('#pages').css({'width': width, 'height': height});
}


// this is the main image scroller function
function mainScroller(scrollable, pages, url){
  this.initialize = scrollerInitialize;
  this.scrollable = scrollable;
  this.pages      = pages;
  this.url        = url;
  this.moveUp     = scrollerMoveUp;
  this.moveDown   = scrollerMoveDown;
  this.move       = scrollerMove;
  this.showDefault = scrollerShowDefault;
  this.effects       = { easing: 'easeOutCirc', axis: 'y' };
  this.effects_speed = 800;
  this.$current  = "";
  this.$previous = "";
  this.haiku_div = $('div.innerPost div.haiku');
  
  var current_page = 1;
  var pages = pages;

  function scrollerInitialize(){
    this.$current = $('div.fullimage:first').eq(0);
    this.$previous = this.$current;
  }

  function scrollerMove(direction, has_effects){
    var current = "";
    
    if (direction == "up"){
      current = this.$current.prev(":not('#default_image')").eq(0);
      
      if (current.attr("class") != "fullimage") {
        current = $("div.fullimage:not('#default_image'):last").eq(0);
      }
    }else if (direction == "down"){
      current = this.$current.next(":not('#default_image')").eq(0);
      
      if (current.attr("class") != "fullimage"){
        if (load_next_page(this.url, this)){
          current = [];
        }else{
          current = $("div.fullimage:not('#default_image'):first").eq(0);
        }
      }
    }else {
      current = this.$current ;
    }
    //console.log(current);
    //console.log(direction);
    if (current.length > 0 ){
      if (has_effects == true ){
        this.scrollable.scrollTo(current, this.effects_speed, this.effects);
      }else{
        this.scrollable.scrollTo(current);
      }
      
      if (direction) { //check if movement is directional if not we dont update the page metadata
        this.$previous = this.$current;
        this.$current = current;
      }
    }
  }

  function scrollerMoveUp(has_effects){
    this.move("up", has_effects);
    hide_default_image(this.$current);
  }

  function scrollerMoveDown(has_effects){
    this.move("down", has_effects);
    hide_default_image(this.$current);
  }

  function scrollerShowDefault(has_effects){
    var default_image = $('#default_image').show();
    if (!this.$current.is('#default_image')){
      this.$previous = this.$current;
      this.$current = default_image.eq(0);
      $(this.scrollable.selector).scrollTo(this.$current, this.effects_speed, this.effects);
    }
  }
  
  // this is private function for hidding the default image
  function hide_default_image(current){
    if (!current.is('#default_image')){
      $('#default_image').hide();
    }
  }

  // private function for loading the next paged images
  function load_next_page(url, scroller){
    if (current_page < pages ){
      current_page++;
      $.get(url, {page: current_page}, function(){
          scroller.moveDown(true);
          $.hide_loader();
          console.log("mvng nxt page")
        }, "script");
      return true
    }else{
      return false
    }
  }

}

function toggleRaveForm(linkSelector, commentsForm){
  var showText = "Add Rave";
  var hideText = "Close Rave Form";
  this.toggle_speed = 900;
  this.$linkSelector = $(linkSelector);
  this.$commentsForm = $(commentsForm);
  
  this.$commentsForm.slideToggle(this.toggle_speed);
  if (this.$linkSelector.text() == showText ){
    this.$linkSelector.text(hideText);
  }else {
    this.$linkSelector.text(showText);
  }
}
