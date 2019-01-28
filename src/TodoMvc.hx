package ;

import js.Browser.*;
import coconut.Ui.hxx;
import todomvc.ui.TodoListView;

class TodoMvc {
  static function main() {
    
    var list = new todomvc.data.TodoList();

    for (i in 0...Std.parseInt(window.location.hash.substr(1)))
      list.add('item $i');

    coconut.ui.Renderer.mount(
      cast document.body.appendChild(document.createDivElement()),
      hxx('<TodoListView todos=${list}/>')
    );
  }
}