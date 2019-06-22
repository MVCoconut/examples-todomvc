package todomvc.haxeui;

import todomvc.data.TodoItem;
import coconut.ui.View;
import haxe.ui.containers.*;
import haxe.ui.components.*;

using StringTools;

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
    <HBox>
      <if ${isEditing}>
        <TextField 
          ref=${tf -> if (tf != null) tf.focus = true} 
          onChange=${edit(event.target.value)} 
          onFocusOut=${isEditing = false} 
          text=${item.description} 
        />
      <else>
        <CheckBox selected=${item.completed} onChange=${item.completed = event.target.selected}/>
        <Label text=${item.description} />
        <Button text="x" />
      </if>
    </HBox>
  ';
}