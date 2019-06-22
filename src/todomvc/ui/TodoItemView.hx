package todomvc.ui;

import todomvc.data.TodoItem;
import coconut.ui.View;
#if haxeui_core
import haxe.ui.containers.*;
import haxe.ui.components.*;
#end

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

  function render() 
    #if haxeui_core
      '
        <HBox>
          <if ${isEditing}>
            <TextField 
              ref=${tf -> if (tf != null) tf.focus = true} 
              onChange=${edit(event.target.value)} 
              onFocusOut=${isEditing = false} 
              text=${item.description} 
            />
          <else>
            <CheckBox selected=${item.completed} onChange=${item.completed = !item.completed} />
            <Label text=${item.description} />
            <Button text="x" />
          </if>
        </HBox>
      '
    #else '
      <li class="todo-item" data-completed=${item.completed} data-editing={js.Lib.undefined}>
        <input name="completed" type="checkbox" checked=${item.completed} onchange={item.completed = event.src.checked} />
        <if ${isEditing}>
          <input ref=${function (i) if (i != null) i.focus()} name="description" type="text" value=${item.description} onchange={edit(event.src.value)} onblur={isEditing = false} />
        <else>
          <span class="description" ondblclick=${this.isEditing = true}>{item.description}</span>
          <button class="delete" onclick=${ondeleted(item)}>Delete</button>
        </if>
      </li>
    '
    #end;

}