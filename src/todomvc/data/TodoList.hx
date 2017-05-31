package todomvc.data;

import coconut.data.*;
import tink.pure.List;

class TodoList implements Model {

  @:observable var items:List<TodoItem> = @byDefault null;

  @:transition function add(description:String) {
    return { items: items.prepend(TodoItem.create(description)) };
  }
  
  @:transition function delete(item)
    return { items: items.filter(i => i != item) };

  @:transition function clearCompleted() 
    return { items: items.filter(i => !i.completed) };

}