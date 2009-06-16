
$(window).load(function(){
  $('#mainContainer').css('visibility', 'visible');
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
  this.effects = [50, { easing: 'linear', axis: 'y' }];
  this.moveUp = scrollerMoveUp;
  this.moveDown = scrollerMoveDown;
  this.move = scrollerMove;
  this.initialize = scrollerInitialize;
  this.$current = "";

  function scrollerInitialize(){
    this.$current = $('div.fullimage:first').eq(0);
  }

  function scrollerMove(direction, has_effects){
    var curr;
    console.log(this.$current);
    if (direction == "up"){
      curr = this.$current.prev().eq(0);
      
      if (curr.attr("class") != "fullimage") {
        curr = $('div.fullimage:last').eq(0);
      }
    }else if (direction == "down"){
      curr = this.$current.next().eq(0);
      
      if (curr.attr("class") != "fullimage"){
        curr = $('div.fullimage:first').eq(0);
      }
    }else {
      curr = this.$current ;
    }
    console.log(direction);
    console.log(curr);
    this.$current = curr;
    this.scrollable.scrollTo(curr, 30, { easing: 'linear', axis: 'y'});
  }

  function scrollerMoveUp(has_effects){
    this.move("up", has_effects);
  }

  function scrollerMoveDown(has_effects){
    this.move("down", has_effects);
  }
}
