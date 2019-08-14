package todomvc.ui;

import todomvc.data.TodoItem;
import coconut.ui.View;
import cix.Style.rule as css;

using StringTools;

class TodoItemView extends View {
  @:attribute var item:TodoItem;
  @:attribute var ondeleted:TodoItem->Void;
  @:state var isEditing:Bool = false;

  static final ROOT = css('
    display: flex;
    align-items: center;
    position: relative;
    list-style: none;
    border-bottom: 1px solid #e4e4e4;
    .description, input[name="description"]  {
      flex-grow: 1;
      padding: 15px;
    }

    input[name="description"] {
      font: inherit;
      border: none;
    }
    &[data-editing] {
      input[name="completed"] {
        visibility: hidden;
      }
    }
    &[data-completed] {
      .description {
        text-decoration: line-through;
        color: #ccc;
      }
      
    }

    input[name="completed"] {
      margin-left: 10px;
      height: 40px;
      &:focus {outline:0;}
      -webkit-appearance: none;
      -moz-appearance: none;
      appearance: none;

      &:checked:after {
        content: url(\'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 -18 100 135"><circle cx="50" cy="50" r="50" fill="none" stroke="%23bddad5" stroke-width="3"/><path fill="%235dc2af" d="M72 25L42 71 27 56l-4 4 20 20 34-52z"/></svg>\');
      }
      &:after {
        content: url(\'data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 -18 100 135"><circle cx="50" cy="50" r="50" fill="none" stroke="%23ededed" stroke-width="3"/></svg>\');
      }    
    }

    &:hover {
      button.delete {
        opacity: .5;
        &:hover {
          opacity: 1;
        }
      }
    }

    button.delete {
      
      flex-basis: 60px;
      align-self: stretch;
      opacity: 0;
      border: none;
      background: none;
      font-size: 0;

      &:after {
        content: "×";
        font-size: 30px;
        color: #af5b5b;
      }
    }  
  ');
  
  function edit(entered:String)
    switch entered.rtrim() {
      case '': ondeleted(item);
      case v: item.description = v;
    }

  function render() '
    <li class=${ROOT} data-completed=${item.completed} data-editing=${isEditing}>
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