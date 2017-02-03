package todomvc.ui;

import js.html.KeyboardEvent;
import vdom.VDom.*;
import todomvc.data.*;
import coconut.ui.*;

@:less("list.less")
class TodoListView extends View<{todos:TodoList, filter:TodoFilter}> {
  function render() '
    <div class="todo-list">
      <header>
        <input type="text" onkeypress={e => if (e.keyCode == KeyboardEvent.DOM_VK_RETURN) { todos.add(e.target.value); e.target.value = ""; }} />
        <if {todos.items.length > 0}>
          <if {todos.items.exists(TodoItem.isActive)}>
            <button class="mark-all" onclick={[] => for (i in todos.items) i.completed = true}>Mark all as completed</button>
          <else>
            <button class="unmark-all" onclick={[] => for (i in todos.items) i.completed = false}>Unmark all as completed</button>
          </if>
        </if>
      </header>
      <ol>
        <for {item in todos.items}>
          <if {filter.matches(item)}>
            <TodoItemView item={item} ondeleted={todos.delete.bind(item)} />
          </if>
        </for>
      </ol>
      <menu>
        <span>
          <switch {todos.items.count(TodoItem.isActive)}>
            <case {1}>1 item
            <case {v}>{v} items
          </switch> left
        </span>
        <for {f in filter.options}>
          <button onclick={[] => filter.toggle(f.value)} data-active={filter.isActive(f.value)}>{f.name}</button>
        </for>
        <if {todos.items.exists(TodoItem.isCompleted)}>
          <button onclick={todos.clearCompleted}>Clear Completed</button>
        </if>
      </menu>
    </div>
  ';
}