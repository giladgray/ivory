
(function() {
  define('keycodes',[],function() {
    return {
      48: '0',
      49: '1',
      50: '2',
      51: '3',
      52: '4',
      53: '5',
      54: '6',
      55: '7',
      56: '8',
      57: '9',
      65: 'A',
      66: 'B',
      67: 'C',
      68: 'D',
      69: 'E',
      70: 'F',
      71: 'G',
      72: 'H',
      73: 'I',
      74: 'J',
      75: 'K',
      76: 'L',
      77: 'M',
      78: 'N',
      79: 'O',
      80: 'P',
      81: 'Q',
      82: 'R',
      83: 'S',
      84: 'T',
      85: 'U',
      86: 'V',
      87: 'W',
      88: 'X',
      89: 'Y',
      90: 'Z',
      96: 'Num0',
      97: 'Num1',
      98: 'Num2',
      99: 'Num3',
      100: 'Num4',
      101: 'Num5',
      102: 'Num6',
      103: 'Num7',
      104: 'Num8',
      105: 'Num9',
      106: 'Times',
      107: 'Plus',
      109: 'Minus',
      110: 'Dot',
      111: 'Slash',
      112: 'F1',
      113: 'F2',
      114: 'F3',
      115: 'F4',
      116: 'F5',
      117: 'F6',
      118: 'F7',
      119: 'F8',
      120: 'F9',
      122: 'F11',
      123: 'F12',
      124: 'F13',
      125: 'F14',
      126: 'F15',
      8: 'Backspace',
      9: 'Tab',
      13: 'Enter',
      16: 'Shift',
      17: 'Ctrl',
      18: 'Alt',
      91: 'Meta',
      93: 'Meta',
      20: 'Caps Lock',
      27: 'Esc',
      32: 'Space',
      33: 'Page Up',
      34: 'Page Down',
      35: 'End',
      36: 'Home',
      37: 'Left',
      38: 'Up',
      39: 'Right',
      40: 'Down',
      45: 'Insert',
      46: 'Delete',
      144: 'Num Lock',
      145: 'ScrLk',
      19: 'Pause',
      186: ';',
      187: '=',
      188: ',',
      189: '-',
      190: '.',
      191: '/',
      192: '`',
      219: '[',
      220: '\\',
      221: ']',
      222: "'"
    };
  });

}).call(this);

(function() {
  var __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  define('keystring',['keycodes'], function(keycodes) {
    var MODIFIERS, MOD_CODES;
    MODIFIERS = {
      ctrlKey: 'Ctrl',
      metaKey: 'Meta',
      altKey: 'Alt',
      shiftKey: 'Shift'
    };
    MOD_CODES = [16, 17, 18, 91, 93];
    return function(event) {
      var modKey, mods, name, _ref;
      if (typeof event === 'number') {
        return keycodes[event];
      } else if (_ref = event.which, __indexOf.call(MOD_CODES, _ref) >= 0) {
        return keycodes[event.which];
      } else {
        mods = (function() {
          var _results;
          _results = [];
          for (modKey in MODIFIERS) {
            name = MODIFIERS[modKey];
            if (event[modKey]) {
              _results.push(name);
            }
          }
          return _results;
        })();
        mods.push(keycodes[event.which]);
        return mods.join('+');
      }
    };
  });

}).call(this);

(function() {
  define('mixins',['keystring'], function(tickle) {
    var keypress;
    window.KEYS = true;
    keypress = function(event) {
      var action, keyname, keystring;
      keystring = tickle(event);
      keyname = '+' + tickle(event.which);
      action = this.keyEvents[keystring] || this.keyEvents[keyname];
      if (window.KEYS) {
        console.log(keystring, action);
      }
      if (keystring === 'Esc') {
        return $(':focus').blur();
      } else if (action && _.isEmpty($(':focus').get())) {
        event.preventDefault();
        if (this[action]) {
          action = this[action];
        }
        if (_.isFunction(action)) {
          return action.call(this, event);
        } else {
          return this.$(action).click();
        }
      }
    };
    return {
      setupIvory: function() {
        var _this = this;
        return $('body').on('keydown.ivory', function(e) {
          return _this.keypress(e);
        });
      },
      teardownIvory: function() {
        return $('body').off('keydown.ivory');
      },
      keypress: keypress
    };
  });

}).call(this);

(function() {
  define('ivory',['keystring', 'mixins'], function(keystring, mixins) {
    return {
      mixins: mixins,
      keystring: keystring,
      tickle: keystring
    };
  });

}).call(this);
