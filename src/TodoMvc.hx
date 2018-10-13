package ;

import js.Browser.*;
import coconut.Ui.hxx;
import todomvc.ui.TodoListView;

class TodoMvc {
  static function main() {
    var list = new todomvc.data.TodoList();
    #if react
    react.ReactDOM.render(
      hxx('<TodoListView todos=${list}/>'),
      cast document.body.appendChild(document.createDivElement())
    );
    #else
    hxx('<TodoListView todos=${list} />').renderInto(document.body.appendChild(document.createDivElement()));
    #end
  }
}