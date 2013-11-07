$(function() {
  $(".one p").lupin();
  $(".two p").lupin({
    ele: "p",
    offset: "2/3"
  });
  $(".three p").lupin({
    animationTime: 200
  });
  $(".four p").lupin({
    offset: "quarter"
  });
});
