package pizzkanban

import grails.converters.JSON

class TaskController {

    def index() {
        println 'index'
        render ( Task.findAll() as JSON)
    }

    def list() {
        println 'list'
        render ( Task.findAll() as JSON)
    }

    def save() {
        println 'save'
        def task = new Task(order: request.JSON.order, name: request.JSON.name, description: request.JSON.description, estimatedTime: request.JSON.estimatedTime)
        if ( task.validate() ) {
            render( task.save() as JSON )
        } else {
            render ( task.errors as JSON )
        }
    }

    def delete() {
        println 'delete'
        def task = Task.findById(params.id)
        task?.delete()
        render(task as JSON )
    }

    def edit() {
        println 'edit'
        def task = Task.findById(params.id)
        bindData(task, request.JSON)
        render(task.save() as JSON )
    }
}
