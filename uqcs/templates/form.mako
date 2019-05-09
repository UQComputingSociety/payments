<%inherit file="base.mako"/>

<div class="row" style="text-align:center">
  <div id="body" class="col-sm-12 col-md-6 col-md-offset-3">
    <img src="/static/logo.png" />
    <h1>2019 UQCS Registration</h1>
    <div class="flash">
      % for category, msg in get_msgs(with_categories=True):
      <div class="alert alert-${category} alert-dismissible" role="alert">
        <button
          type="button"
          class="close"
          data-dismiss="alert"
          aria-label="Close"
        >
          <span aria-hidden="true">&times;</span>
        </button>
        ${msg}
      </div>
      % endfor
    </div>
    <form method="POST" id="fullForm" action="/" name="payForm">
      <div class="form-group">
        <label for="fnameInput">First Name<span class="reqstar">*</span></label>
        <input
          type="text"
          class="form-control"
          id="fnameInput"
          placeholder="First Name"
          name="fname"
          required="required"
        />
      </div>
      <div class="form-group">
        <label for="lnameInput">Last Name<span class="reqstar">*</span></label>
        <input
          type="text"
          class="form-control"
          id="lnameInput"
          placeholder="Last Name"
          name="lname"
          required="required"
        />
      </div>
      <div class="form-group">
        <label for="emailInput"
          >Email address <span class="reqstar">*</span></label
        >
        <input
          name="email"
          type="email"
          class="form-control"
          id="emailInput"
          placeholder="Email"
          required="required"
        />
      </div>
      <div class="form-group">
        <label>Gender</label><br />
        <div class="btn-group-toggle" data-toggle="buttons">
          <div class="btn-group">
            <label class="btn btn-primary"> 
              <input name="gender" type="radio" value="M" /> Male 
            </label>
            <label class="btn btn-primary">
              <input name="gender" type="radio" value="F" /> Female
            </label>
          </div>
          <br />
          <div class="btn-group" style="padding-top:10px">
            <label class="btn btn-primary">
              <input
                name="gender"
                type="radio"
                value="null"
                data-bind="checked: gender"
                checked
              />
              Other / Prefer not to disclose
            </label>
          </div>
        </div>
      </div>
      <div class="form-group">
        <label for="memberType"
          >Member Type <span class="reqstar">*</span></label
        >
        <div class="checkbox">
          <label>
            <input name="student" type="checkbox" id="studentCheckbox" /> Are
            you currently a UQ student?
          </label>
        </div>
      </div>
      <div id="student-form-section" style="display:none;">
        <div class="form-group">
          <label for="student-no"
            >Student Number <span class="reqstar">*</span></label
          >
          <input
            type="text"
            name="student-no"
            class="form-control"
            id="studentNo"
            placeholder="43108765"
          />
          <p class="help-block">8 digits, no 's'</p>
        </div>
        <div class="form-group">
          <label>Domestic or International</label> <br />
          <div class="btn-group btn-group-toggle" data-toggle="buttons">
            <label class="btn btn-primary">
              <input type="radio" value="domestic" name="domORint" /> Domestic
            </label>
            <label class="btn btn-primary">
              <input type="radio" value="international" name="domORint" />
              International
            </label>
          </div>
        </div>
        <div class="form-group">
          <label>Degree/Program</label>
          <input
            type="text"
            name="degree"
            class="form-control"
            placeholder="e.g. BEng (Software)"
          />
        </div>
        <div class="form-group">
          <label>Degree Type</label> <br />
          <div class="btn-group btn-group-toggle" data-toggle="buttons">
            <label class="btn btn-primary">
              <input type="radio" value="undergrad" name="degreeType" />
              Undergraduate
            </label>
            <label class="btn btn-primary">
              <input type="radio" value="postgrad" name="degreeType" /> Postgraduate
            </label>
          </div>
        </div>
        <div class="form-group">
          <label>Year</label> <br />
          <div class="btn-group btn-group-toggle" data-toggle="buttons">
            <label class="btn btn-primary">
              <input type="radio" name="year" value="1" /> 1
            </label>
            <label class="btn btn-primary">
              <input type="radio" name="year" value="2" /> 2
            </label>
            <label class="btn btn-primary">
              <input type="radio" name="year" value="3" /> 3
            </label>
            <label class="btn btn-primary">
              <input type="radio" name="year" value="4" /> 4
            </label>
            <label class="btn btn-primary">
              <input type="radio" name="year" value="5" /> 5+
            </label>
          </div>
        </div>
      </div>
      <input type="hidden" name="stripeToken" value="" id="stripeToken" />
      <input
        class="btn btn-success"
        type="submit"
        name="submission"
        value="Pay Online"
        id="submitbtn"
      />
      <input
        class="btn btn-primary"
        name="submission"
        type="submit"
        value="Pay Cash"
      />
    </form>
    <div class="text-muted">
      <p></p>
      <p>Online payments have a 40c card surcharge.</p>
    </div>
    <h3>Want to register with QPAY?</h3>
    <p style="text-align: justify; text-align-last: center;">
      As nearly all clubs and societies will be required to use QPAY for 2019,
      UQCS will offer QPAY signup as a secondary method. QPAY is not required
      for interacting with UQCS other than co-hosted events with clubs that
      choose to do ticketing with QPAY.
    </p>
    <div class="text-muted">
      <p></p>
      <p style="text-align: justify; text-align-last: center;">
        UQCS does not endorse QPAY, you should do your own research to see if
        QPAY is right for you.
      </p>
    </div>
    <a role="button" class="btn btn-warning" href="https://joinuqcs.getqpay.com"
      >Signup with QPAY</a
    >
  </div>
</div>
<script src="https://checkout.stripe.com/checkout.js"></script>
<script type="text/javascript">
  var handler = StripeCheckout.configure({
    key: "${STRIPE_PUBLIC_KEY}",
    locale: "auto",
    token: function(token) {
      $("#stripeToken").val(token.id);
      $("#submitbtn").click();
    }
  });
  $("#submitbtn").on("click", function(e) {
    e.preventDefault();
    if (!$("#fullForm")[0].checkValidity()) {
      return;
    }
    handler.open({
      name: "UQCS",
      description: "2019 Membership",
      currency: "aud",
      amount: 540,
      email: $("#emailInput").val()
    });
  });
  $(window).on("popstate", function() {
    handler.close();
  });
  $("#studentCheckbox").change(function(e) {
    if ($("#studentCheckbox")[0].checked) {
      $("#student-form-section").slideDown();
      $("#studentNo").attr("required", "true");
    } else {
      $("#student-form-section").slideUp();
      $("#studentNo").attr("required", null);
    }
  });
</script>

<script>
    function validId(id) {
        if (id.length !== 8) {
            return false;
        }
        let validFormat = RegExp(/[1-5][0-9]{7}$/).test(id);
        let validValue = ( 9 * parseInt(id[0]) +
                           7 * parseInt(id[1]) +
                           3 * parseInt(id[2]) +
                           9 * parseInt(id[3]) +
                           7 * parseInt(id[4]) +
                           3 * parseInt(id[5]) +
                           9 * parseInt(id[6]) ) % 10 === parseInt(id[7]);
        return validFormat && validValue;
    }

    function checkId() {
        let field = document.getElementById("studentNo");
        let id = document.getElementById("studentNo").value;
        console.log(id);
        if (validId(id)) {
            field.setCustomValidity("");
        } else {
            field.setCustomValidity("Must be exactly 8 numeric digits");
        }
    }

    window.onload = function () {
        document.getElementById("studentNo").onchange = checkId;
    }
</script>