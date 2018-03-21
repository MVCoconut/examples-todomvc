package todomvc.ui;

import todomvc.data.TodoItem;
import coconut.ui.View;

using StringTools;

@:less("item.less")
class TodoItemView extends View {
  @:attribute var item:TodoItem;
  @:attribute var ondeleted:TodoItem->Void;
  @:state var isEditing:Bool = false;

  function render() {

    function edit(entered:String)
      switch entered.rtrim() {
        case '': ondeleted(item);
        case v: item.description = v;
      }

    return @hxx '
      <li title="${this.viewId}" class="todo-item" data-completed=${item.completed} data-editing={isEditing}>
        <input name="completed" type="checkbox" checked=${item.completed} onchange={item.completed = event.target.checked} />
        <if ${isEditing}>
          <input name="description" type="text" value=${item.description} onchange={edit(event.target.value)} onblur={isEditing = false} />
        <else>
          <span class="description" ondblclick=${this.isEditing = true}>{item.description}</span>
          <button class="delete" onclick=${ondeleted(item)}>Delete</button>
        </if>
      </li>
    ';
  }
  override function afterPatching(_) 
    if (isEditing)
      get('input[type="text"]').focus();
  
}