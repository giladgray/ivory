ivories.js
==========
A simple, elegant, flexible library for JavaScript key events.
> Make them keys dance!

## Overview

Ivories.js provides for two primary use cases:

1. a function to convert a KeyEvent to a friendly readable string, such as `Ctrl+N` or `Alt+Shift+Tab`.

```
$ ivories.tickle(event)
Ctrl+N
```
2. a mixin object for Backbone.View (or other similar frameworks) to enable binding to key events as easy as pie.

```javascript
MyView = Backbone.View.extend(ivories)
MyView.keyEvents = {
  'Esc'    : 'blur :focus'      // simple keybinding
  'Ctrl+N' : 'click #new-item'  // explicit modifiers
  '+Tab'   : 'changeTab'        // modifier globbing
}
MyView.changeTab = function(...) { ... } 
```

## Usage

Simply install it from bower, add it to your app's config file, and require it in a [RequireJS](http://requirejs.org) `define()` call and use as above.

```javascript
require.config({
  paths: {
    ...
    'ivories' : '../bower_components/ivories/ivories'
  }
})

define(['ivories'], function (ivories) {
  // your magic here
}
```
