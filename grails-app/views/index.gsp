<!DOCTYPE html>
<html>

  <head>
    <title>Our Über Kanban !!!</title>
    <r:require module="application" />
    <meta name="layout" content="main">
  </head>

  <body>

     %{--Task App Interface --}%

    <div id="taskapp">

      <div class="title">
        <h1>Tasks</h1>
        <h3>in CoffeeScript</h3>
      </div>

      <div class="content">

        <div id="create-task">
          <input id="new-task" placeholder="What needs to be done?" type="text" />
          <span class="ui-tooltip-top" style="display:none;">Press Enter to save this task</span>
        </div>

        <div id="tasks">
          <ul id="task-list"></ul>
        </div>

        <div id="task-stats"></div>

      </div>

    </div>

    %{--Templates --}%

    <script type="text/template" id="item-template">
      <div class="task {{ done ? 'done' : '' }}">
        <div class="display">
          <input class="check" type="checkbox" {{ done ? 'checked="checked"' : '' }} />
          <div class="task-content"></div>
          <span class="task-destroy"></span>
        </div>
        <div class="edit">
          <input class="task-input" type="text" value="" />
        </div>
      </div>
    </script>

    <script type="text/template" id="stats-template">
      {! if (total) { !}
        <span class="task-count">
          <span class="number">{{ remaining }}</span>
          <span class="word">{{ remaining == 1 ? 'item' : 'items' }}</span> left.
        </span>
      {! } !}
      {! if (done) { !}
        <span class="task-clear">
          <a href="#">
            Clear <span class="number-done">{{ done }}</span>
            completed <span class="word-done">{{ done == 1 ? 'item' : 'items' }}</span>
          </a>
        </span>
      {! } !}
    </script>

  </body>
</html>
