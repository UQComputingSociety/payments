<%inherit file="base.mako"/>

<div class="row justify-content-md-center">
  <div id="body" class="col-sm-12 col-md-6 col-lg-4">
    <div id="header" class="text-left">
      <img id="logo" src="/static/logo-blue-outline.svg"/>
      <h3 style="margin:0; margin-left: 20px;line-height:1;">UQCS 2020 Registration</h3>
    </div>
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
        <label for="fnameInput">First Name <span class="reqstar">*</span></label>
        <input
          type="text"
          class="form-control"
          id="fnameInput"
          placeholder="John"
          name="fname"
          required="required"
        />
      </div>
      <div class="form-group">
        <label for="lnameInput">Last Name <span class="reqstar">*</span></label>
        <input
          type="text"
          class="form-control"
          id="lnameInput"
          placeholder="Smith"
          name="lname"
          required="required"
        />
      </div>
      <div class="form-group">
        <label for="emailInput"
          >Email Address <span class="reqstar">*</span></label
        >
        <input
          name="email"
          type="email"
          class="form-control"
          id="emailInput"
          placeholder="john@example.com"
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
            <label class="btn btn-primary active">
              <input
                name="gender"
                type="radio"
                value="null"
                data-bind="checked: gender"
                checked
              />
              Other / Unspecified
            </label>
          </div>
        </div>
      </div>
      <div class="form-group">
        <label>Are you a current UQ student? <span class="reqstar">*</span></label> <br />
        <div class="btn-group btn-group-toggle" data-toggle="buttons">
          <label class="btn btn-primary active">
            <input type="radio" value="on" name="student" checked id="studentCheckbox"/>
            Yes
          </label>
          <label class="btn btn-primary">
            <input type="radio" value="" name="student"/>
            No
          </label>
        </div>
      </div>
      <hr/>
      <div id="student-form-section">
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
          <p class="form-text text-muted">8 digits, without the 's'.</p>
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
          <label>Degree&thinsp;/&thinsp;Program</label>
          <input
            type="text"
            name="degree"
            class="form-control"
            placeholder="BEng (Software)"
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
              <input type="radio" value="postgrad" name="degreeType" /> 
              Postgraduate
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
        <hr/>
      </div>
      <input type="hidden" name="stripeToken" value="" id="stripeToken" />
      
      <p>
        Membership is <b>$5</b> for one year. 
        Online payments have a 40c surcharge.
      </p>
      <input
        class="btn btn-info btn-lg"
        name="submit"
        type="submit"
        id="payonline_submit"
        value="Pay Online"
      />
      <input
        class="btn btn-info btn-lg"
        type="submit"
        name="submission"
        value="Pay Online"
        style="display:none;"
        id="submitbtn"
      />
      <input
        class="btn btn-info btn-lg"
        name="submission"
        type="submit"
        value="Pay Cash"
      />
    </form>
    <br/>
    <div class="text-muted">
      <p>
        Membership expires at the end of the February of the next calendar year
        (${expiry_today}).
        <!-- Membership purchased from ${start_future} will expire on ${expiry_future}. -->
      </p>
    </div>
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
  $("#payonline_submit").on("click", function(e) {
    e.preventDefault();
    if (!$("#fullForm")[0].checkValidity()) {
      return;
    }
    handler.open({
      name: "UQCS",
      description: "2020 Membership",
      currency: "aud",
      amount: 540,
      email: $("#emailInput").val()
    });
  });
  $(window).on("popstate", function() {
    handler.close();
  });
  $("input[name=student]").change(function(e) {
    if (e.target.value === 'on') {
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
            let text = "Invalid student number.";
            if (id.length != 8)
                text = text + " Must be 8 digits.";
            field.setCustomValidity(text);
        }
    }

    window.onload = function () {
        document.getElementById("studentNo").onchange = checkId;
    }
</script>