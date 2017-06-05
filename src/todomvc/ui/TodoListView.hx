package todomvc.ui;

import js.html.KeyboardEvent;
import todomvc.data.*;
import coconut.ui.*;

@:less("list.less")
class TodoListView extends View<{todos:TodoList, filter:TodoFilter}> {
  function render() '
    <div class="todo-list" data-empty={todos.items.length == 0}>
      <h1>todos</h1>
      <header>
        <input type="text" placeholder="What needs to be done?" onkeypress={e => if (e.keyCode == KeyboardEvent.DOM_VK_RETURN) { todos.add(e.target.value); e.target.value = ""; }} />
        <if {todos.items.length > 0}>
          <if {todos.items.exists(TodoItem.isActive)}>
            <button class="mark-all" onclick={for (i in todos.items) i.completed = true}>Mark all as completed</button>
          <else>
            <button class="unmark-all" onclick={for (i in todos.items) i.completed = false}>Unmark all as completed</button>
          </if>
        </if>
      </header>
      <if {todos.items.length > 0}>
        <ol>
          <for {item in todos.items}>
            <if {filter.matches(item)}>
              <TodoItemView key={item} item={item} ondeleted={todos.delete(item)} />
            </if>
          </for>
        </ol>
        <footer>
          
          <span>
            <switch {todos.items.count(TodoItem.isActive)}>
              <case {1}>1 item
              <case {v}>{v} items
            </switch> left
          </span>
  
          <menu>
            <for {f in filter.options}>
              <button onclick={filter.toggle(f.value)} data-active={filter.isActive(f.value)}>{f.name}</button>
            </for>
          </menu>
  
          <if {todos.items.exists(TodoItem.isCompleted)}>
            <button onclick={todos.clearCompleted}>Clear Completed</button>
          </if>
          
        </footer>
      </if>
    </div>
  ';

  override function afterInit(_) {
    @in(.01) @do get('header input').focus();
  }
}