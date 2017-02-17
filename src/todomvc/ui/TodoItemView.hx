package todomvc.ui;

import todomvc.data.TodoItem;
import coconut.ui.View;
import vdom.VDom.*;
using StringTools;

@:less("item.less")
class TodoItemView extends View<{ item: TodoItem, ondeleted: Void->Void }> {
  
  @:state var isEditing:Bool = false;

  function render() {

    function edit(entered:String)
      switch entered.rtrim() {
        case '': ondeleted();
        case v: item.description = v;
      }

    return @hxx '
      <div class="todo-item" data-completed={item.completed} data-editing={isEditing}>
        <input name="completed" type="checkbox" checked={item.completed} onchange={e => item.completed = e.target.checked} />
        <if {isEditing}>
          <input name="description" type="text" value={item.description} onchange={e => edit(e.target.value)} onblur={_ => isEditing = false} />
        <else>
          <span class="description" ondblclick={_ => this.isEditing = true}>{item.description}</span>
          <button class="delete" onclick={ondeleted}>Delete</button>
        </if>
        <div>
          <p>{item.test}</p><p>{item.getTest()}</p>
        </div>
      </div>
    ';
  }
  override function afterUpdate() 
    if (isEditing)
      get('input[type="text"]').focus();
  
}