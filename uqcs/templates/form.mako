<%inherit file="base.mako"/>

<%block name="head_extra">

</% block>

<div class="row justify-content-md-center">
  <div id="body" class="col-sm-12 col-md-9 col-lg-5">
    <div id="header" class="container-fluid">
      <div class="row justify-content-center align-items-center">
        <img id="logo" class="col-lg-4 col-xl-5" src="/static/logo-blue-outline.svg"/>
        <h2 
          class="col-sm-12 col-lg-8 col-xl-7 text-center"
          style="margin:0; line-height:1;"
        >
          UQCS 2020 Registration
        </h2>
      </div>
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
          <div class="btn-group w-100">
            <label class="btn btn-primary"> 
              <input name="gender" type="radio" value="M" /> Male 
            </label>
            <label class="btn btn-primary">
              <input name="gender" type="radio" value="F" /> Female
            </label>
            <label class="btn btn-primary">
              <input
                name="gender"
                type="radio"
                value="null"
                data-bind="checked: gender"
              />
              Other / Unspecified
            </label>
          </div>
        </div>
      </div>
      <div class="form-group">
        <label>Are you a current UQ student? <span class="reqstar">*</span></label> <br />
        <div class="btn-group btn-group-toggle wide-buttons" data-toggle="buttons">
          <label class="btn btn-primary">
            <input type="radio" value="on" name="student" required id="studentCheckbox"/>
            Yes
          </label>
          <label class="btn btn-primary">
            <!-- Using radio buttons to emulate a checkbox. 
              Server treats empty strings as false. -->
            <input type="radio" value="" name="student" required/>
            No
          </label>
        </div>
      </div>
      <div id="student-form-section" style="display: none;">
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
          <p class="form-text text-muted">8 digits, no 's'.</p>
        </div>
        <div class="form-group">
          <label>Domestic or International</label> <br />
          <div class="btn-group btn-group-toggle wide-buttons" data-toggle="buttons">
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
          <label>Degree Type</label> <br />
          <div class="btn-group btn-group-toggle wide-buttons" data-toggle="buttons">
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
          <label>Degree&thinsp;/&thinsp;Program</label>
          <input
            type="text"
            id="degreeInput"
            name="degreeInput"
            class="form-control"
            placeholder="Bachelor of Engineering"
          />
        </div>
        <div class="form-group">
          <label>Major</label>
          <input
            type="text"
            id="majorInput"
            name="majorInput"
            class="form-control"
            placeholder="Software Engineering"
          />
        </div>
        <input type="hidden" id="degree" name="degree">
        
        <div class="form-group">
          <label>Year</label> <br />
          <div class="btn-group btn-group-toggle wide-buttons" data-toggle="buttons">
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
      
      <!-- This hidden button is clicked after successful stripe payments. -->
      <input
        class="btn btn-info btn-lg"
        type="submit"
        name="submission"
        value="Pay Online"
        id="submitbtn"
        style="display:none;"
      />
      
      <div class="btn-toolbar justify-content-between my-4">
        <input 
          style="width: 49%;"
          class="btn btn-info btn-lg" 
          name="submit" 
          type="submit" 
          id="payonline_submit"
          value="Pay online"
        />
        <input 
          style="width: 49%;"
          class="btn btn-info btn-lg"
          name="submission" 
          type="submit" 
          value="Pay in person"
        />
      </div>

    </form>

    <p class="text-muted">
      Membership is <b>$5</b> for one year. 
      Online card payments have a <b>40c</b> surcharge. 
      In person card payments have a <b>10c</b> surcharge.
    </p>
    <p class="text-muted">
      Membership expires at the end of February of the <i>next</i> calendar year
      (${expiry_today}).
      <!-- Membership purchased from ${start_future} will expire on ${expiry_future}. -->
    </p>
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
    var form = $("#fullForm")[0];
    if (!form.checkValidity()) {
      form.reportValidity();
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
    if ($("input[name=student]:checked")[0].value === 'on') {
      $("#student-form-section").slideDown();
      $("#studentNo").attr("required", "true");
    } else {
      $("#student-form-section").slideUp();
      $("#studentNo").attr("required", null);
    }
  });
</script>
<style>
/* some styles lifted from Bootstrap */
.autocomplete-suggestions { border: 1px solid #222; border-radius: 0.25rem; background: #FFF; overflow: auto; }
.autocomplete-suggestion { cursor: pointer; }
.autocomplete-suggestion, .autocomplete-no-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; color: black; height: calc(1.5em + 0.75rem + 2px); padding: 0.375rem 0.75rem; line-height: 1.5}
.autocomplete-selected { background: #F0F0F0; }
.autocomplete-suggestions strong { font-weight: normal; color: #3399FF; }
.autocomplete-group { padding: 2px 5px; }
.autocomplete-group strong { display: block; border-bottom: 1px solid #000; }
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.4.10/jquery.autocomplete.min.js" integrity="sha256-xv9tRiSlyBQMvBkQeqNyojOQf45uTVXQAtIMrmgqV18=" crossorigin="anonymous"></script>
<script>
  const degrees = [{"value": "Bachelor of Advanced Science", "data": "undergrad"}, {"value": "Bachelor of Advanced Business", "data": "undergrad"}, {"value": "Bachelor of Advanced Finance and Economics", "data": "undergrad"}, {"value": "Bachelor of Arts", "data": "undergrad"}, {"value": "Bachelor of Biomedical Science", "data": "undergrad"}, {"value": "Bachelor of Business Management", "data": "undergrad"}, {"value": "Bachelor of Biotechnology", "data": "undergrad"}, {"value": "Bachelor of Computer Science", "data": "undergrad"}, {"value": "Bachelor of Engineering", "data": "undergrad"}, {"value": "Bachelor of Engineering and Master of Engineering", "data": "undergrad"}, {"value": "Bachelor of Information Technology", "data": "undergrad"}, {"value": "Bachelor of Mathematics", "data": "undergrad"}, {"value": "Bachelors of Business Management/Information Technology", "data": "undergrad"}, {"value": "Bachelors of Commerce/Information Technology", "data": "undergrad"}, {"value": "Bachelors of Computer Science/Arts", "data": "undergrad"}, {"value": "Bachelors of Computer Science/Science", "data": "undergrad"}, {"value": "Bachelors of Engineering/Arts", "data": "undergrad"}, {"value": "Bachelors of Engineering/Biotechnology", "data": "undergrad"}, {"value": "Bachelors of Engineering/Business Management", "data": "undergrad"}, {"value": "Bachelors of Engineering/Commerce", "data": "undergrad"}, {"value": "Bachelors of Engineering/Computer Science", "data": "undergrad"}, {"value": "Bachelors of Engineering/Economics", "data": "undergrad"}, {"value": "Bachelors of Engineering/Information Technology", "data": "undergrad"}, {"value": "Bachelors of Engineering/Mathematics", "data": "undergrad"}, {"value": "Bachelors of Engineering/Science", "data": "undergrad"}, {"value": "Bachelors of Information Technology/Arts", "data": "undergrad"}, {"value": "Bachelors of Information Technology/Science", "data": "undergrad"}, {"value": "Bachelor of Science/Laws", "data": "undergrad"}, {"value": "Bachelors of Mathematics/Arts", "data": "undergrad"}, {"value": "Bachelors of Mathematics/Business Management", "data": "undergrad"}, {"value": "Bachelors of Mathematics/Commerce", "data": "undergrad"}, {"value": "Bachelors of Mathematics/Computer Science", "data": "undergrad"}, {"value": "Bachelors of Mathematics/Economics", "data": "undergrad"}, {"value": "Bachelors of Mathematics/Education (Secondary)", "data": "undergrad"}, {"value": "Bachelors of Mathematics/Information Technology", "data": "undergrad"}, {"value": "Bachelors of Mathematics/Science", "data": "undergrad"},  {"value": "Doctor of Philosophy", "data": "postgrad"}, {"value": "Graduate Certificate of Bioinformatics", "data": "postgrad"}, {"value": "Graduate Certificate of Biotechnology", "data": "postgrad"}, {"value": "Graduate Certificate of Computer Science", "data": "postgrad"}, {"value": "Graduate Certificate of Cyber Security", "data": "postgrad"}, {"value": "Graduate Certificate of Engineering Science", "data": "postgrad"}, {"value": "Graduate Certificate of Information Technology", "data": "postgrad"}, {"value": "Graduate Diploma of Biotechnology", "data": "postgrad"}, {"value": "Graduate Diploma of Computer Science", "data": "postgrad"}, {"value": "Graduate Diploma of Cyber Security", "data": "postgrad"}, {"value": "Graduate Diploma of Information Technology", "data": "postgrad"}, {"value": "Graduate Certificate of Science", "data": "postgrad"}, {"value": "Masters of Bioinformatics", "data": "postgrad"}, {"value": "Masters of Bioinformatics Research Extensive", "data": "postgrad"}, {"value": "Masters of Biotechnology", "data": "postgrad"}, {"value": "Masters of Biotechnology Research Extensive", "data": "postgrad"}, {"value": "Masters of Computer Science", "data": "postgrad"}, {"value": "Masters of Computer Science (Management)", "data": "postgrad"}, {"value": "Masters of Cyber Security", "data": "postgrad"}, {"value": "Masters of Data Science", "data": "postgrad"}, {"value": "Masters of Engineering", "data": "postgrad"}, {"value": "Masters of Engineering Science", "data": "postgrad"}, {"value": "Masters of Engineering Science (Management)", "data": "postgrad"}, {"value": "Masters of Financial Mathematics", "data": "postgrad"}, {"value": "Master of Geographic Information Science", "data": "postgrad"},{"value": "Masters of Information Technology", "data": "postgrad"}, {"value": "Master of Interaction Design", "data": "postgrad"}, {"value": "Master of Philosophy", "data": "postgrad"}, {"value": "Masters of Quantum Technology", "data": "postgrad"}];
  let degreeType;
  $("input[name=degreeType]").change(function(e) {
    const selected = $("input[name=degreeType]:checked")[0];
    degreeType = selected ? selected.value : null;
  });
  $('#degreeInput').autocomplete({
    lookup: degrees,
    showNoSuggestionNotice: true,
    noSuggestionNotice: 'No suggestions, please enter manually.',
    lookupFilter: function (suggestion, query, queryLowerCase) {
      if (degreeType && suggestion.data != degreeType)
        return false; // if degree type (under/postgrad) doesn't match, omit.
      // match ALL space-separated tokens in query.
      const s = suggestion.value.toLowerCase();
      return queryLowerCase.split(' ')
        .filter(q => q.length && s.indexOf(q) == -1).length == 0;
    }
  });
  $('#fullForm').submit(function(ev) {
    // fudge together combined degree field from degree name and major.
    const major = $('#majorInput').val().trim();
    let degree = $('#degreeInput').val().trim();
    if (major)
      degree = degree + ' (' + major + ')';
    $('#degree').val(degree);
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
<%!
import json
def to_json(d):
    return json.dumps(d)
%>
<script>
  // Loads previous form state from server.
  const form = ${to_json(form) | n};
  if (form) {
    ['fname', 'lname', 'email', 'student-no', 'degree', 'degreeInput', 'majorInput'].forEach(name => {
      $('input[name="'+name+'"]').val(form[name]);
    });
    ['gender', 'student', 'domORint', 'degreeType', 'year'].forEach(name => {
      $('input[name="'+name+'"]').val([form[name]]);
    });
    // Update visibility of student details.
    setTimeout(() => {
      $("input[name=student]:checked").change();
    }, 0);
  }
</script>
