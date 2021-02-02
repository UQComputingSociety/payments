<%inherit file="base.mako"/>

<%block name="head_extra">
<script src="https://js.stripe.com/v3/"></script>
<script>
const stripe = Stripe("${STRIPE_PUBLIC_KEY}");
const origin = window.location.origin;

stripe.redirectToCheckout({
  lineItems: [{
  price: "${STRIPE_PRICE_ID}",
  quantity: 1,
  }],
  mode: 'payment',
  successUrl: origin + '/complete?session={{CHECKOUT_SESSION_ID}}',
  cancelUrl: origin,
});
</script>
</% block>

<div class="columns is-centered is-mobile">
<div id="body" class="column" style="max-width: 450px;">
Please wait while redirecting...
</div>
</div>