modules = {
    application {
        dependsOn 'jquery, underscore, backbone'
        resource url: [dir: 'libs/bootstrap', file: 'bootstrap.less'], attrs: [rel: "stylesheet/less", type: 'css'], disposition: 'head'
        //resource url: '/css/main.css'
    }

    tasks {
        dependsOn 'application'
        resource url: '/coffee/tasks.coffee'
    }

    'jquery-form' {
        resource url: '/js/jquery.form.js'
    }

    backbone {
        resource url: '/js/backbone.js'
    }
    underscore {
        resource url: '/js/underscore-1.1.6.js'
    }
}