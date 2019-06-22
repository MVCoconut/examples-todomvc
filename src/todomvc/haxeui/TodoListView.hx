package todomvc.haxeui;

import todomvc.data.*;
import coconut.ui.*;

import haxe.ui.containers.*;
import haxe.ui.components.*;
import haxe.ui.core.Component;

using StringTools;

class TodoListView extends View {
  @:attribute var todos:TodoList = new TodoList();
  @:attribute var filter:TodoFilter = new TodoFilter();

  function render() '
    <VBox>
      <Label text="todos" />
      <Header {...this} />
      <if {todos.items.length > 0}>
        <for {item in todos.items}>
          <if {filter.matches(item)}>
            <TodoItemView key={item} item={item} ondeleted={todos.delete(item)} />
          </if>
        </for>
        <Footer {...this} />
      </if>
    </VBox>
  ';
}

class Header extends View {
  @:attribute var todos:TodoList;
  @:ref var tf:TextField;
  function handleSubmit()
    switch tf.text.trim() {
      case '':
      case v: 
        todos.add(v); 
        tf.text = "";
    }
  function render() '
    <HBox>
      <if ${todos.items.length > 0}>
        <if ${todos.unfinished > 0}>
          <Button onClick=${for (i in todos.items) i.completed = true} text="Mark all" />
        <else>
          <Button onClick=${for (i in todos.items) i.completed = false} text="Unmark all" />
        </if>
      </if>
      <TextField ref=${tf} placeholder="What needs to be done?" onKeyDown={e => if (e.keyCode == 13) handleSubmit()} />
    </HBox>
  ';

  function viewDidMount()
    tf.focus = true;
  
}

class Footer extends View {
  @:attribute var todos:TodoList;
  @:attribute var filter:TodoFilter;

  function render() '
    <HBox>
      
      <Label 
        text=${switch todos.unfinished {
          case 1: '1 item left';
          case v: '$v items left';
        }} 
      />

      <HBox>
        <for {f in filter.options}>
          <Button toggle onClick={filter.toggle(f.value)} selected={filter.isActive(f.value)} text=${f.name}/>
        </for>
      </HBox>

      <if {todos.hasAnyCompleted}>
        <Button onClick={todos.clearCompleted} text="Clear Completed" />
      </if>
      
    </HBox>
  ';
}