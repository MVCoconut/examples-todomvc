package todomvc.ui;

import js.html.*;
import todomvc.data.*;
import coconut.ui.*;

class TodoListView extends View {
  static var ROOT = cix.Style.rule('
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    button, input[type="checkbox"] {
      cursor: pointer;
    }

    button, input {
      font: inherit;
      &:focus {
        outline:0;
      }
    }

    h1 {
      position: absolute;
      top: -150px;
      color: rgba(175, 91, 94, 0.25);
      font-size: 100px;
      font-weight: 100;
      text-align: center;
      width: 100%;

    }

    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    html {
      background: #f5f5f5; /* TODO: move to global namespace */
    }
    font-size: 24px;
    box-sizing: border-box;
    padding: 0;
    margin: 200px auto 50px;
    width: 550px;
    position: relative;
    background: white;
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 25px 50px 0 rgba(0, 0, 0, 0.1);

    ol {
      border-top: 2px solid #e4e4e4;
    }

    &:not([data-empty]):after {
      content: " ";
      position: absolute;
      right: 0;
      bottom: 0;
      left: 0;
      height: 50px;
      overflow: hidden;
      pointer-events: none;
      box-shadow: 0 1px 1px rgba(0, 0, 0, 0.2), 0 8px 0 -3px #f6f6f6, 0 9px 1px -3px rgba(0, 0, 0, 0.2), 0 16px 0 -6px #f6f6f6, 0 17px 2px -6px rgba(0, 0, 0, 0.2);
    }
    footer {
      font-size: 14px;
      color: #777;
      padding: 0 15px;
      display: flex;
      align-items: center;
      height: 45px;
      justify-content: space-between;
      position: relative;
      button {
        color: inherit;
        font: inherit;
        background: none;
        border: none;
        padding: 3px 7px;
      }
      menu {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        display: flex;
        pointer-events: none;
        justify-content: center;
        align-items: center;
        button {
          pointer-events: all;
          margin: 0 3px;
          border: 1px solid transparent;
          border-radius: 2px;
          &:hover {
            border-color: rgba(175, 91, 94, 0.2);
          }
          &[data-active] {
            border-color: rgba(175, 91, 94, 0.5);
          }
        }
      }
      &>button {
        &:hover {
          text-decoration: underline;
        }
      }
    }
    header {
      position: relative;
      input[type="text"] {
        width: 100%;
        padding: 19px;
        padding-left: 60px;
        border: none;
        font: inherit;
        &::-webkit-input-placeholder {
          font-style: italic;
          font-weight: 300;
          color: #e6e6e6;
        }
        &::-moz-placeholder {
          font-style: italic;
          font-weight: 300;
          color: #e6e6e6;
        }
        &::placeholder {
          font-style: italic;
          font-weight: 300;
          color: #e6e6e6;
        }
      }
      button {
        position: absolute;
        background: none;
        border: 0;
        font-size: 0;
        top: 0;
        left: 0;
        bottom: 0;
        width: 62px;
        &.mark-all:before {
          opacity: .5;
        }
        &:before {
          color: #737373;
          margin: 0 auto;
          font-size: 22px;
          content: "❯";
          transform: rotate(90deg);
          display: block;
        }
      }
    }
  ');
  @:attribute var todos:TodoList = new TodoList();
  @:attribute var filter:TodoFilter = new TodoFilter();

  function render() '
    <div class=${ROOT} data-empty=${todos.items.length == 0}>
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