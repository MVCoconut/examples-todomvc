package todomvc.ui;

import js.html.*;
import todomvc.data.*;
import coconut.ui.*;

@:less("list.less")
class TodoListView extends View {
  @:attribute var todos:TodoList = new TodoList();
  @:attribute var filter:TodoFilter = new TodoFilter();

  function render() '
    <div class="todo-list">
      <h1>todos</h1>
      <Header {...this} />
      <if {todos.items.length > 0}>
        <ol>
          <for {item in todos.items}>
            <if {filter.matches(item)}>
              <TodoItemView key={item} item={item} ondeleted={todos.delete(item)} />
            </if>
          </for>
        </ol>
        <Footer {...this} />
      </if>
    </div>
  ';
}

class Header extends View {
  @:attribute var todos:TodoList;
  @:ref var input:InputElement;
  function render() '
    <header>
      <input ref=${input} type="text" placeholder="What needs to be done?" onkeypress={e => if (e.which == KeyboardEvent.DOM_VK_RETURN && e.src.value != "") { todos.add(e.src.value); e.src.value = ""; }} />
      <if {todos.items.length > 0}>
        <if {todos.unfinished > 0}>
          <button class="mark-all" onclick={for (i in todos.items) i.completed = true}>Mark all as completed</button>
        <else>
          <button class="unmark-all" onclick={for (i in todos.items) i.completed = false}>Unmark all as completed</button>
        </if>
      </if>
    </header>
  ';

  function viewDidMount()
    input.focus();
  
}

class Footer extends View {
  @:attribute var todos:TodoList;
  @:attribute var filter:TodoFilter;
  function render() '
    <footer>
      
      <span>
        <switch {todos.unfinished}>
          <case {1}>1 item
          <case {v}>{v} items
        </switch> left
      </span>

      <menu>
        <for {f in filter.options}>
          <button onclick={filter.toggle(f.value)} data-active={filter.isActive(f.value)}>{f.name}</button>
        </for>
      </menu>

      <if {todos.hasAnyCompleted}>
        <button onclick={todos.clearCompleted}>Clear Completed</button>
      </if>
      
    </footer>
  ';
}