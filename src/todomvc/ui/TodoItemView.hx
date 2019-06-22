package todomvc.ui;

import todomvc.data.TodoItem;
import coconut.ui.View;

using StringTools;

@:less("item.less")
class TodoItemView extends View {
  @:attribute var item:TodoItem;
  @:attribute var ondeleted:TodoItem->Void;
  @:state var isEditing:Bool = false;

  function edit(entered:String)
    switch entered.rtrim() {
      case '': ondeleted(item);
      case v: item.description = v;
    }

  function render() '
    <li class="todo-item" data-completed=${item.completed} data-editing={js.Lib.undefined}>
      <input name="completed" type="checkbox" checked=${item.completed} onchange={item.completed = event.src.checked} />
      <if ${isEditing}>
        <input ref=${function (i) if (i != null) i.focus()} name="description" type="text" value=${item.description} onchange={edit(event.src.value)} onblur={isEditing = false} />
      <else>
        <span class="description" ondblclick=${this.isEditing = true}>{item.description}</span>
        <button class="delete" onclick=${ondeleted(item)}>Delete</button>
      </if>
    </li>
  ';

}