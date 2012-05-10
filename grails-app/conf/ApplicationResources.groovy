modules = {
    application {
        dependsOn 'jquery, underscore, backbone, dnd'
        resource url: [dir: 'libs/bootstrap', file: 'bootstrap.less'], attrs: [rel: "stylesheet/less", type: 'css'], disposition: 'head'
        
        resource url: '/coffee/tasks.coffee'
        resource url: '/css/main.css'
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
    dnd {
        resource url: '/js/jquery.dnd.js'
    }
}