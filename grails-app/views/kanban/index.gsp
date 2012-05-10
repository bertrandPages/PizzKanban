<html>
<head>
  <meta name='layout' content='main'/>
</head>

<body>
<div class="background">
  <div class="post-it">Lorem ipsum</div>
</div>
<r:script>
  $(function () {
    $('.background').dnd('dragstart', function () {
      alert('test');
    })
  });
</r:script>
</body>
</html>