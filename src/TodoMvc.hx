package ;

import js.Browser.*;
import coconut.Ui.hxx;
import todomvc.ui.TodoListView;

class TodoMvc {
  static function main() 
    document.body.appendChild(
      hxx('<TodoListView />').toElement()
    );
}