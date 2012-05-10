modules = {
    application {
        dependsOn 'jquery, underscore, backbone, dnd'
        resource url: 'libs/bootstrap/bootstrap.less', attrs: [rel: "stylesheet/less", type: 'css'], disposition: 'head'
        resource url:'js/application.js'
    }
    backbone {
        resource url: '/js/backbone.js'
    }
    underscore {
        resource url: '/js/underscore-1.1.6.js'
    }
    dnd {
        dependsOn 'jquery'
        resource url: '/js/jquery.dnd.js'
    }
}