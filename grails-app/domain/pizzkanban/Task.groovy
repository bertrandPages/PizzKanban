package pizzkanban

class Task {

    Integer order

    String name
    String description
    Long estimatedTime

    Boolean done = false


    static constraints = {
        name(nullable: false)
        description(nullable: true)
        estimatedTime(nullable: false)
    }

    static mapping = {
        table('kanban_task')
        order column: 'task_order'
    }
}
