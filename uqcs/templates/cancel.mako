<%inherit file="base.mako"/>

<div class="columns is-centered is-mobile">
<div id="body" class="column" style="max-width: 450px;">
<p class="my-3">
    Payment cancelled.
    Please go back and try again or choose "pay in person".
</p>
<p>
<button
    class="button is-link"
    onclick="javascript:history.go(-3)"
>
    <b>Back to form</b>
</button>
</p>
</div>
</div>
