<%inherit file="base.mako"/>
<%block name="head_extra">
</% block>
<div class="row justify-content-md-center">
<div class="col-xs-12 col-md-8" style="margin-top: 40px;">
<span style="font-size: 100px">&#x1F389;</span>
<h1>Thank you for joining the UQ Computing Society!</h1>
<p style="font-size: 15pt;">
% if member.has_paid():
Your payment has been accepted and you are now a registered UQCS member!
% else:
Come visit our market day stall or our welcome event to pay for your membership!
% endif
</p>
<p><a href="/" class="btn btn-info">Back to form</a></p>
</div>
</div>
