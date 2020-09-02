package ;

import js.Browser.*;
import coconut.Ui.hxx;

#if haxeui_core
import haxe.ui.core.*;
#end

class TodoMvc {
  static function main() {

    var list = new todomvc.data.TodoList();

    for (i in 0...Std.parseInt(window.location.hash.substr(1)))
      list.add('item $i');

    #if haxeui_core
      var root = new Component();
      Screen.instance.addComponent(root);
      root.width = 500;
      root.height = 500;
      coconut.ui.Renderer.mount(
        root,
        hxx('<todomvc.haxeui.TodoListView todos=${list} />')
      );

      haxe.ui.Toolkit.init();
    #else
      coconut.ui.Renderer.mount(
        cast document.body.appendChild(document.createDivElement()),
        hxx('<todomvc.ui.TodoListView todos=${list}/>')
      );

      #if tink_state_test_subs
        var out = document.createDivElement();
        document.body.appendChild(out);
        out.setAttribute('style', 'background: white; border: 1px solid black; padding: 10px; margin: 10px; top: 0; left: 0');
        var timer = new haxe.Timer(100);
        timer.run = function () {
          out.innerText = 'active: ' + @:privateAccess tink.state.Observable.subscriptionCount();
        }
      #end
    #end

    #if hotswap
      hotswap.Runtime.permaPoll();
    #end
  }
}