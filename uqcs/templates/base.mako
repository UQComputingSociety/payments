<!DOCTYPE html>
<html>
<head>
<title>Join UQCS 2021</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- Favicon -->
<link rel="apple-touch-icon" sizes="180x180" href="/static/apple-touch-icon.png">
<link rel="icon" type="image/png" href="/static/favicon-32x32.png" sizes="32x32">
<link rel="icon" type="image/png" href="/static/favicon-16x16.png" sizes="16x16">
<link rel="mask-icon" href="/static/safari-pinned-tab.svg" color="#5bbad5">
<meta name="theme-color" content="#ffffff">
<link rel="stylesheet" href="//static.uqcs.org/bulma/main.css">
<style type="text/css">
.reqstar{color:red;}
body{color: white; background-color: #414141;}
html,body{min-height: 100vh}
#unpaid-members td {vertical-align:middle;}
#logo{width: 200px;}
hr{border-top:1px solid white;}
.title,.label,.radio:hover{color: white;}
.buttons.wide{width: 100%; display: flex;}
.buttons.wide .button{flex: 1;}
</style>

<%block name="head_extra">
</%block>

</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.5.0/knockout-min.js" integrity="sha256-Tjl7WVgF1hgGMgUKZZfzmxOrtoSf8qltZ9wMujjGNQk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<section class="section">
<div class="container">
${next.body()}
</div>
</section>
</body>
</html>
