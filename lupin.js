(function($) {
  return $.fn.lupin = function(options) {
    var defaults,
      _this = this;
    defaults = {
      offset: "1/3",
      animationTime: 400
    };
    this.init = function() {
      _this.opts = $.extend({}, defaults, options);
      _this.windowHeight = $(window).height();
      _this.counter = 0;
      _this.setOffset();
      _this.hide();
    };
    this.setOffset = function() {
      switch (_this.opts.offset) {
        case "1/2":
        case "2/4":
        case "3/6":
        case "half":
          _this.opts.offset = _this.windowHeight / 2;
          break;
        case "1/3":
          _this.opts.offset = _this.windowHeight / 3 * 2;
          break;
        case "2/3":
          _this.opts.offset = _this.windowHeight / 3;
          break;
        case "1/4":
        case "quarter":
          _this.opts.offset = _this.windowHeight / 4 * 3;
          break;
        case "3/4":
          _this.opts.offset = _this.windowHeight / 4;
      }
      _this.offsetTop = _this.offset().top - _this.opts.offset;
    };
    this.hide = function() {
      if (typeof poke !== "undefined" && poke !== null) {
        if (poke.ie6()) {
          _this.css({
            "visibility": "hidden"
          });
        } else {
          _this.css({
            "opacity": 0
          });
        }
      } else {
        _this.css({
          "opacity": 0
        });
      }
    };
    this.disp = function() {
      if (typeof poke !== "undefined" && poke !== null) {
        if (poke.ie6()) {
          _this.css({
            "visibility": "visible"
          });
        } else {
          if (_this.opts.animationTime === 0) {
            _this.css({
              "opacity": "1"
            });
          } else {
            _this.animate({
              "opacity": "1"
            }, _this.opts.animationTime);
          }
        }
      } else {
        _this.animate({
          "opacity": "1"
        }, _this.opts.animationTime);
      }
      _this.counter = 0;
    };
    this.watchWindowSize = function() {};
    this.alertScrollTop = function() {
      $(window).scroll(function() {
        var scroll;
        scroll = $(window).scrollTop();
        if (_this.offsetTop < scroll) {
          if (_this.counter !== 1) {
            _this.counter = 1;
            return _this.disp();
          }
        }
      });
    };
    this.init();
    this.alertScrollTop();
    return this;
  };
})(jQuery);
