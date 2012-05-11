<!DOCTYPE html>
<html>

  <head>
    <title>Our Über Kanban !!!</title>
    <r:require modules="application, tasks" />
    <meta name="layout" content="main">
  </head>

  <body>

     %{--Task App Interface --}%

    <div id="taskapp">

      <div class="title">
        <h1>Kanban</h1>
      </div>

      <div class="content">

        <div id="create-task">
          <label>Name:</label><input id="new-task-name" placeholder="Name" type="text" required="required" />
          <label>Description:</label><textarea id="new-task-description" placeholder="Description (optional)" ></textarea>
          <label>Estimated time:</label><input id="new-task-estimated-time" placeholder="Estimated time" type="number" required="required" />
          <button id="save-new-task">Save task!</button>
        </div>

        <div id="tasks">
          <ul id="task-list"></ul>
        </div>

        <div id="task-stats"></div>

      </div>

    </div>

    %{--Templates --}%

    <script type="text/template" id="item-template">
      <div class="task {{ done ? 'done' : '' }} post-it">
        <div class="display">
          <input class="check" type="checkbox" {{ done ? 'checked="checked"' : '' }} />
          <strong><div class="task-name"></div></strong>
          <div class="task-description"></div>
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
