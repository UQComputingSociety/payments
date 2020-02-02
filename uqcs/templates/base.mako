<!DOCTYPE html>
<html>
<head>
<title>Join UQCS 2020</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- Favicon -->
  <link rel="apple-touch-icon" sizes="180x180" href="static/apple-touch-icon.png">
  <link rel="icon" type="image/png" href="static/favicon-32x32.png" sizes="32x32">
  <link rel="icon" type="image/png" href="static/favicon-16x16.png" sizes="16x16">
  <link rel="mask-icon" href="static/safari-pinned-tab.svg" color="#5bbad5">
  <meta name="theme-color" content="#ffffff">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
<style type="text/css">
iframe{display:block;}
.reqstar{color:red;}
body{background-image: url('/static/bg.png'); background-size: cover; padding-bottom: 50px;}
html,body{min-height: 100%}
.row,.container{min-height: 100%}
.container{padding-top: 20px;}
#body{color: white;min-height:100%;}
</style>

<%block name="head_extra">
</%block>

</head>
<body>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/knockout/3.4.0/knockout-min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<div class="container">
${next.body()}
</div>
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
</body>
</html>
