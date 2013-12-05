Ivory
==========
A simple, elegant, flexible library for JavaScript key events.
> Make them keys dance!

## Overview

Ivories.js provides for two primary use cases:

1) a function to convert a KeyEvent to a friendly readable string, such as `Ctrl+N` or `Alt+Shift+Tab`.

```
> ivories.tickle(event)
  Cmd+Space
```

2) a mixin object for Backbone.View (or other similar frameworks) to enable binding to key events as easy as pie.

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

```bash
# 1. Install from bower
$ bower install ivories --save
```

```javascript
// 2. add to require config
require.config({
  paths: {
    ...
    'ivories' : '../bower_components/ivories/ivories'
  }
})
```

```javascript
// 3. require in a module
define(['ivories'], function (ivories) {
  // your magic here
}
```
