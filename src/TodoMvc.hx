package ;

import js.Browser.*;
import coconut.Ui.hxx;
import todomvc.data.*;
import todomvc.ui.*;

class TodoMvc {
  static function main() {

    document.body.appendChild(
      hxx('
        <TodoListView filter={new TodoFilter()} todos={new TodoList()}/>
      ').toElement()
    );
  }
}