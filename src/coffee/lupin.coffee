#
# * 要素を好きな位置に表示させたり消したりする
# * lupin
# * @option element
# * @return true
#
( ($)->
  $.fn.lupin = (options) ->

    # option
    defaults =
      # ele: ".lupin"
      offset: "1/3"
      animationTime: 400

    @.init = ()=>
      # option
      @.opts = $.extend({}, defaults, options)

      # ウィンドウの高さを取得
      @.windowHeight = $(window).height();

      # 各種変数
      @.counter = 0

      # catch element
      # @.catchEle()
      # get offset top
      @.setOffset()
      # hide element
      @.hide()

      return

    # 要素の中から表示切り替えする要素を捕まえる
    # @.catchEle = () =>
    #   @.catchedEle = @.find( @.opts.ele )
    #   return

    # 要素を表示させるまでの位置をセット
    @.setOffset = ()=>
      # オプションの offset が
      # "half" "1/2" だったら画面の半分
      # "quarter" "1/4" だったら画面の1/4
      # "1/3" だったら画面の1/3
      switch @.opts.offset
        when "1/2","2/4", "3/6", "half"
          @.opts.offset = @.windowHeight / 2
        when "1/3"
          @.opts.offset = @.windowHeight / 3 * 2
        when "2/3"
          @.opts.offset = @.windowHeight / 3
        when "1/4", "quarter"
          @.opts.offset = @.windowHeight / 4 * 3
        when "3/4"
          @.opts.offset = @.windowHeight / 4 * 1

      @.offsetTop = @.offset().top - @.opts.offset
      return

    # 要素を非表示にする
    @.hide = ()=>
      if poke?
        if poke.ie6()
          @.css "visibility":"hidden"
        else
          @.css "opacity":0
      else
        @.css "opacity":0
      return

    # 要素を表示する
    @.disp = ()=>
      if poke?
        if poke.ie6()
          @.css "visibility":"visible"
        else
          if @.opts.animationTime is 0
            @.css "opacity":"1"
          else
            @.animate "opacity":"1", @.opts.animationTime
      else
        @.animate "opacity":"1", @.opts.animationTime
      @.counter = 0
      return

    # ウィンドウサイズ変更時の関数
    @.watchWindowSize = ()=>
      return

    @.alertScrollTop = ()=>
      $( window ).scroll =>
        scroll = $( window ).scrollTop()

        if @.offsetTop < scroll
          if @.counter isnt 1
            @.counter = 1
            @.disp()
      return

    @.init()
    @.alertScrollTop()

    return @

) jQuery
