# used by underscore to specify the template syntax
_.templateSettings = {
    interpolate : /\{\{(.+?)\}\}/g,
    evaluate : /\{!(.+?)!\}/g
};

# Load the application once the DOM is ready, using a `jQuery.ready` shortcut.
$ ->    
    ### Task Model ###

    class Task extends Backbone.Model
        # Default attributes for the task.
        defaults:
            name: "Name of the task"
            description: "description of the task"
            estimatedTime: "estimated duration of the task"
            done: false

        # Ensure that each task created has name & description
        initialize: ->
            if !@get("name")
                @set({ "name": @defaults.name })
            if !@get("description")
                @set({ "description": @defaults.description })

        # Toggle the `done` state of this task item.
        toggle: ->
            @save({ done: !@get("done") })

        # Remove this Task from the server and delete its view.
        clear: ->
            @destroy()
            @view.remove()

    ### Task Collection ###

    class TaskList extends Backbone.Collection

        # Reference to this collection's model.
        model: Task

        # TODO find a better way to set the URL
        url: '/PizzKanban/tasks',

        # Attribute getter/setter
        getDone = (task) ->
            return task.get("done")

        getName = (task) ->
            return task.get("name")

        getDescription = (task) ->
                  return task.get("description")

        # Filter down the list of all task items that are finished.
        done: ->
            return @filter( getDone )

        # Filter down the list to only task items that are still not finished.
        remaining: ->
            return @without.apply( this, @done() )

        # We keep the Tasks in sequential order, despite being saved by unordered
        # ID in the database. This generates the next order number for new items.
        nextOrder: ->
            return 1 if !@length
            return @last().get('order') + 1

        # Tasks are sorted by their original insertion order.
        comparator: (task) ->
            return task.get("order")

    ### Task Item View ###

    # The DOM element for a task item...
    class TaskView extends Backbone.View

        #... is a list tag.
        tagName:  "li"

        # Cache the template function for a single item.
        template: _.template( $("#item-template").html() )

        # The DOM events specific to an item.
        events:
            "click .check"              : "toggleDone",
            "dblclick div.task-description" : "edit",
            "click span.task-destroy"   : "clear",
            "keypress .task-input"      : "updateOnEnter"

        # The TaskView listens for changes to its model, re-rendering. Since there's
        # a one-to-one correspondence between a **Task** and a **TaskView** in this
        # app, we set a direct reference on the model for convenience.
        initialize: ->
            @model.bind('change', this.render);
            @model.view = this;

        # Re-render the descriptions of the task item.
        render: =>
            this.$(@el).html( @template(@model.toJSON()) )
            @setContent()
            return this

        # To avoid XSS (not that it would be harmful in this particular app),
        # we use `jQuery.text` to set the descriptions of the task item.
        setContent: ->
            description = @model.get("description")
            this.$(".task-description").text(description)
            @input = this.$(".task-input");
            @input.bind("blur", @close);
            @input.val(description);

        # Toggle the `"done"` state of the model.
        toggleDone: ->
            @model.toggle()

        # Switch this view into `"editing"` mode, displaying the input field.
        edit: =>
            this.$(@el).addClass("editing")
            @input.focus()

        # Close the `"editing"` mode, saving changes to the task.
        close: =>
            @model.save({ description: @input.val() })
            $(@el).removeClass("editing")

        # If you hit `enter`, we're through editing the item.
        updateOnEnter: (e) =>
            @close() if e.keyCode is 13

        # Remove this view from the DOM.
        remove: ->
            $(@el).remove()

        # Remove the item, destroy the model.
        clear: () ->
            @model.clear()

    ### The Application ###

    # Our overall **AppView** is the top-level piece of UI.
    class AppView extends Backbone.View
        # Instead of generating a new element, bind to the existing skeleton of
        # the App already present in the HTML.
        el_tag = "#taskapp"
        el: $(el_tag)

        # Our template for the line of statistics at the bottom of the app.
        statsTemplate: _.template( $("#stats-template").html() )

        # Delegated events for creating new items, and clearing completed ones.
        events:
#            "keyup #new-task"     : "showTooltip",
            "click .task-clear a" : "clearCompleted",
            "click #save-new-task"   : "createOnSave"

        # At initialization we bind to the relevant events on the `Tasks`
        # collection, when items are added or changed. Kick things off by
        # loading any preexisting tasks that might be saved in *localStorage*.
        initialize: =>
            @nameInput = this.$("#new-task-name")
            @descriptionInput = this.$("#new-task-description")
            @estimatedTimeInput = this.$("#new-task-estimated-time")

            Tasks.bind("add", @addOne)
            Tasks.bind("reset", @addAll)
            Tasks.bind("all", @render)

            Tasks.fetch()

        # Re-rendering the App just means refreshing the statistics -- the rest
        # of the app doesn't change.
        render: =>
            this.$('#task-stats').html( @statsTemplate({
                total:      Tasks.length,
                done:       Tasks.done().length,
                remaining:  Tasks.remaining().length
            }))

        # Add a single task item to the list by creating a view for it, and
        # appending its element to the `<ul>`.
        addOne: (task) =>
            view = new TaskView( {model: task} )
            this.$("#task-list").append( view.render().el )

        # Add all items in the **Tasks** collection at once.
        addAll: =>
            Tasks.each(@addOne);

        # Generate the attributes for a new Task item.
        newAttributes: ->
            return {
                name: @nameInput.val(),
                description: @descriptionInput.val(),
                estimatedTime: @estimatedTimeInput.val(),
                order:   Tasks.nextOrder(),
                done:    false
            }

        createOnSave: (e) ->
            Tasks.create( @newAttributes() )
            @nameInput.val('')
            @descriptionInput.val('')
            @estimatedTimeInput.val('')

        # Clear all done task items, destroying their models.
        clearCompleted: ->
            _.each(Tasks.done(), (task) ->
                task.clear()
            )
            return false

#        # Lazily show the tooltip that tells you to press `enter` to save
#        # a new task item, after one second.
#        showTooltip: (e) ->
#            tooltip = this.$(".ui-tooltip-top")
#            name = @nameInput.val()
#            description = @descriptionInput.val()
#            tooltip.fadeOut()
#            clearTimeout(@tooltipTimeout) if (@tooltipTimeout)
#            return if (name is '' || name is @nameInput.attr("placeholder"))
#
#            show = () ->
#                tooltip.show().fadeIn()
#            @tooltipTimeout = _.delay(show, 1000)

    # Create our global collection of **Tasks**.
    # Note: I've actually chosen not to export globally to `window`.
    # Original documentation has been left intact.
    Tasks = new TaskList
    App = new AppView()

