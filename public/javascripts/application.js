
$(window).load(function(){
  $('#mainContainer').css('visibility', 'visible');
  $('#audioPlayer').show();
});

function refigure() {
 var height = $(window).height();
 var width = $(window).width();

 $('div.fullimage img').css({'width': width , 'height': height });
 $('div.fullimage').css({'width': width , 'height': height });
 $('#mainContainer').css({'width': width, 'height': height});
}


// this is the main image scroller function
function mainScroller(scrollable){
  this.scrollable = scrollable;
  this.effects = { easing: 'easeOutCirc', axis: 'y' };
  this.effects_speed = 1000;
  this.moveUp = scrollerMoveUp;
  this.moveDown = scrollerMoveDown;
  this.move = scrollerMove;
  this.showDefault = scrollerShowDefault;
  this.initialize = scrollerInitialize;
  this.$current = "";
  this.$previous = "";
  this.haiku_div = $('div.innerPost div.haiku');

  function scrollerInitialize(){
    this.$current = $('div.fullimage:first').eq(0);
    this.$previous = this.$current;
    update_page_info(this.$current);
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
        current = $("div.fullimage:not('#default_image'):first").eq(0);
      }
    }else {
      current = this.$current ;
    }
    //console.log(current);
    //console.log(direction);
    if (has_effects == true ){
      this.scrollable.scrollTo(current, this.effects_speed, this.effects);
    }else{
      this.scrollable.scrollTo(current);
    }
    
    //if (direction && $("div.fullimage:not('#default_image')").length > 1) {
    if (direction) {
      this.$previous = this.$current;
      this.$current = current;
      update_page_info(this.$current);
      this.haiku_div.show(this.effects_speed);
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
      update_page_info(this.$current);
      this.haiku_div.show(this.effects_speed);
    }
  }
  
  // this is a private function for update the page information
  function update_page_info(current) {
    soundFile         = current.attr("data-mp3");
    page_title        = current.attr("data-title");
    page_published_on = current.attr("data-published-on");
    post         = $('.post');
    inner_post   = $('.innerPost').hide();
    haiku        = $('.haiku', current).html();
    credits      = $('.credits', current).html();
    audio_player = $('.audioPlayer', current).html();
    post.find('.haiku').html(haiku);
    post.find('.credits').html(credits);
    post.find('.pageTitle').html(page_title);
    post.find('.pagePublishedOn').html(page_published_on);
    inner_post.show(1000);
    post.find('.audioPlayer').html(audio_player);
    //    setupAudioPlayer(soundFile);
  }
  
  // this is private function for hidding the default image
  function hide_default_image(current){
    if (!current.is('#default_image')){
      $('#default_image').hide();
    }
  }

  // this is a private function for updating the audioPlayer on the page
  function setupAudioPlayer(soundFile){
    var flashvars = {};
    flashvars.playerId = "1";
    flashvars.bg = "#000000";
    flashvars.loop = "true";
    flashvars.soundFile = soundFile;
    var params = {};
    params.loop = "true";
    params.menu = "false";
    params.quality = "high";
    params.wmode = "opaque";
    params.bgcolor = "#000000"
    params.allowscriptaccess = "never";
    var attributes = {};
    attributes.id = "audioPlayerContainer";
    swfobject.embedSWF("player.swf", "audioPlayerContainer", "290", "24", "9.0.0", false, flashvars, params, attributes);
  }

}

// (JQuery extension) this is for collapse/expand links
(function($) {
  $.fn.link_to_colex = function(selector, options) {
    var settings = $.extend($.fn.link_to_colex.default_options, options, {});
    $(this).addClass(settings.colex_class)
           .removeClass(settings.excol_class)
           .click(function() {
               $(selector).slideToggle(settings.toggle_speed);
               $(this).toggleClass(settings.colex_class)
                      .toggleClass(settings.excol_class);
               return false;
            });
  };

  $.fn.link_to_colex.default_options = { excol_class: 'excol', colex_class: 'colex',  toggle_speed: 450 }
})(jQuery);

