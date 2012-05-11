<html>
<head>
  <meta name='layout' content='main'/>
</head>

<body>
<div class="background">
  <div class="column" title="En attente">
    <div draggable="true" class="post-it">En tant que hipster je peux uploader mon postit de manière hispterisé afin d'être à fond dans le hype.</div>
  </div>
  <div class="column" title="En cours">
    <div draggable="true" class="post-it">Satet</div>
  </div>
  <div class="column" draggable="true" title="Fini">
    <div draggable="true" class="post-it">Dolor</div>
  </div>
</div>
<r:script>
  $(function () {
    $.event.props.push('dataTransfer');
    $('.post-it').on({
      dragstart:function (event) {
        event.dataTransfer.setData('text/html', $(this).html());
        $(this).addClass("dragged");
      },
      drop:function(event) {
        var data = event.dataTransfer.getData('text/html');
        $(this).append('<div draggable="true" class="post-it">'+data+'</div>');
        $(this).removeClass('dragged');
        event.stopPropagation();
      }
    });
    $.event.props.push('dataTransfer');
    $('.column').on({
      dragover:function(event) {
        event.preventDefault();
      },
      dragenter:function(event) {
        $(this).addClass('col-hover');
      },
      dragleave:function(event) {
        $(this).removeClass('col-hover');
      },
      drop:function (event) {
        var data = event.dataTransfer.getData('text/html');
        $(this).append('<div draggable="true" class="post-it">'+data+'</div>');
      }
    });
  });
</r:script>
</body>
</html>