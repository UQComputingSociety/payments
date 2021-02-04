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
.table,.table thead th{background-color: inherit;color: inherit;}
.table.is-striped tbody tr:not(.is-selected):nth-child(even){background-color: rgba(255, 255, 255, 0.075);}
.select.wide,.select.wide>select{ width:100%; }
.field.is-grouped.is-equal-width > .control {flex-basis: 1px;}
#student-form-section{ transition: opacity 250ms linear; }
</style>

<%block name="head_extra">
</%block>

</head>
<body>
<section class="section">
<div class="container">
${next.body()}
</div>
</section>
</body>
</html>
