package ;

import js.Browser.*;
import coconut.Ui.hxx;
import todomvc.ui.TodoListView;

class TodoMvc {
  static function main() {
    // react.ReactDOM.render(
    //   hxx('<TodoListView />'),
    //   cast document.body.appendChild(document.createDivElement())
    // );
    hxx('<TodoListView />').mountInto(document.body.appendChild(document.createDivElement()));
  }
}