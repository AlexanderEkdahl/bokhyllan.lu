// memoize
// rate limiting

var Autocomplete = function(element, menu, index) {
  this.element  = element
  this.menu     = menu
  this.index    = algolia_index;
  this.shown    = false
  this.results  = []
  this.active   = -1
  this.previous = element.value
  this.listen()
}

Autocomplete.prototype = {
  select: function() {
    if (this.active >= 0) {
      window.location = this.results[this.active].url
    } else {
      this.element.parentNode.submit()
    }
  },

  expand: function() {
    if (this.active < 0 && this.results.length > 0) {
      this.active = 0
      this.element.value = this.results[this.active].name
      this.show()
    } else {
      this.select()
    }
  },

  compareQueries: function(a, b) {
    // strips leading whitespace and condenses all whitespace
    a = (a || '').replace(/^\s*/g, '').replace(/\s{2,}/g, ' ');
    b = (b || '').replace(/^\s*/g, '').replace(/\s{2,}/g, ' ');

    return a === b;
  },

  lookup: function() {
    query = this.element.value

    if(this.compareQueries(query, this.previous)) return
    this.previous = query

    if (query == '') return this.hide()

    this.index.search(query, this.process.bind(this))
  },

  show: function() {
    this.menu.innerHTML  = this.render()
    this.shown           = true
  },

  hide: function() {
    this.menu.innerHTML  = ""
    this.shown           = false
  },

  process: function(_, content) {
    if (content.query == this.element.value) {
      this.results = content.hits
      this.show()
    }
  },

  render: function() {
    return this.results.map(this.single.bind(this)).join('')
  },

  span: function(item) {
    span = []
    list = [item._highlightResult.authors, item._highlightResult.courses]

    for (var i in list) {
      for (var j in list[i]) {
        if (list[i][j].matchLevel != 'none') {
          span.push(list[i][j].value)
        }
      }
    }

    var element = document.createElement("span")
    element.innerHTML = span.join(' ')
    return element.outerHTML
  },

  single: function(item) {
    var element = document.createElement("a")
    element.setAttribute("href", item.url)
    element.innerHTML = item._highlightResult.name.value + this.span(item)
    return element.outerHTML
  },

  move: function(e) {
    e.preventDefault()

    switch(e.keyCode) {
      case 38: // up arrow
        this.prev()
        break

      case 40: // down arrow
        this.next()
        break
    }

    if (this.active < 0) {
      this.element.value = this.previous
    } else {
      this.element.value = this.results[this.active].name
    }

    // this.clearLabel()
  },

  next: function() {
    if (this.results.length) {
      this.active++
      if (this.active >= this.results.length) this.active = - 1
    }
  },

  prev: function() {
    if (this.results.length) {
      this.active--
      if (this.active < -1) this.active = this.results.length - 1
    }
  },

  listen: function() {
    this.element.onkeyup   = this.keyup.bind(this)
    this.element.onkeydown = this.keydown.bind(this)
    this.element.onfocus   = this.focus.bind(this)
    this.element.onblur    = this.blur.bind(this)

    this.menu.onmouseenter = this.mouseenter.bind(this)
    this.menu.onmouseleave = this.mouseleave.bind(this)
  },

  keyup: function (e) {
    switch(e.keyCode) {
      case 40: // down arrow
      case 38: // up arrow
      case 16: // shift
      case 17: // ctrl
      case 18: // alt
        break

      case 9: // tab
        if (!this.shown) return
        this.expand()
        break
      case 13: // enter
        if (!this.shown) return
        this.select()
        break

      case 27: // escape
        if (!this.shown) return
        this.hide()
        break

      default:
        this.lookup()
    }

    e.stopPropagation()
    e.preventDefault()
  },

  keydown: function(e) {
    if (!this.shown) return

    switch(e.keyCode) {
      case 9: // tab
      case 13: // enter
      case 27: // escape
        e.preventDefault()
        break

      case 38: // up arrow
        this.move(e)
        break

      case 40: // down arrow
        this.move(e)
        break
    }

    e.stopPropagation()
  },

  focus: function() {
    this.show()
  },

  blur: function() {
    if (!this.mousedover) this.hide()
  },

  mouseenter: function() {
    this.mousedover = true
  },

  mouseleave: function() {
    this.mousedover = false
  }
}
