modules = {
    application {
        dependsOn 'jquery, underscore, backbone'

        resource url:'js/application.js'
    }
    backbone {
        resource url: '/js/backbone.js'
    }
    underscore {
        resource url: '/js/underscore-1.1.6.js'
    }
}