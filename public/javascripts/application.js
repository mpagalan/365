
function refigure() {
 var height = $(window).height();
 var width = $(window).width();

 $('div.fullimage img').css({'width': width , 'height': height });
 $('div.fullimage').css({'width': width , 'height': height });
 $('#mainContainer').css({'width': width, 'height': height});
}

$(window).ready(function(){
  refigure();
 $('#mainContainer').css('visibility','visible');
});

$(window).resize( function (){
  refigure();
});

// this is the main image scroller function
var 
function mainScroller(){
  var effects = [50, { easing: 'linear', axis: 'y' }]
 // if (direction == 'up')
  this.moveUp = scrollerMoveUp;
  this.moveDown = scrollerMoveDown;
  this.move = scrollerMove;

}
