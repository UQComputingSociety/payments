<!DOCTYPE html>
<html>
<head>
<title>Join UQCS 2020</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- Favicon -->
<link rel="apple-touch-icon" sizes="180x180" href="/static/apple-touch-icon.png">
<link rel="icon" type="image/png" href="/static/favicon-32x32.png" sizes="32x32">
<link rel="icon" type="image/png" href="/static/favicon-16x16.png" sizes="16x16">
<link rel="mask-icon" href="/static/safari-pinned-tab.svg" color="#5bbad5">
<meta name="theme-color" content="#ffffff">
<link rel="stylesheet" href="/static/bootstrap.min.css">
<style type="text/css">
iframe{display:block;}
.reqstar{color:red;}
body{background-image: url('/static/bg.png'); background-repeat: repeat; padding-bottom: 50px;}
html,body{min-height: 100%}
.row,.container{min-height: 100%}
.container{padding-top: 20px;}
#unpaid-members td {vertical-align:middle;}
#body{color: white;min-height:100%;}
#header{margin-bottom:40px;margin-top:20px;}
#logo{width: 200px;margin-bottom:20px;margin-top:20px;}
hr{border-top:1px solid white;}
.wide-buttons{display: flex;}
.wide-buttons .btn{width: 100%;}
</style>

<%block name="head_extra">
</%block>

</head>
<body>
<script src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.5.0/knockout-min.js" integrity="sha256-Tjl7WVgF1hgGMgUKZZfzmxOrtoSf8qltZ9wMujjGNQk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
<div class="container">
${next.body()}
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha256-WqU1JavFxSAMcLP2WIOI+GB2zWmShMI82mTpLDcqFUg=" crossorigin="anonymous"></script>
</body>
</html>
