<%inherit file="base.mako"/>
<%block name="head_extra">
<meta http-equiv="refresh" content="15;url=/"/> 
</% block>
<div class="row justify-content-md-center">
<div class="col-xs-12 col-md-8" style="margin-top: 40px;">
<span style="font-size: 100px">&#x1F389;</span>
<h1>Welcome to the UQ Computing Society, ${member.first_name}!</h1>
<p style="font-size: 15pt;">
% if member.has_paid():
Your payment has been accepted and you are now a registered UQCS member!
% else:
Come visit our market day stall or our welcome event to pay for your membership!
% endif
</p>
<p>
    <a href="/" class="btn btn-info" style="margin-right: 20px;">Back to form</a>
    (going back to form in 15 seconds...)
</p>
</div>
</div>
