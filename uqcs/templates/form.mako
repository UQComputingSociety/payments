<%inherit file="base.mako"/>

<%block name="head_extra">
<script src="https://js.stripe.com/v3/"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.slim.min.js" integrity="sha512-/DXTXr6nQodMUiq+IUJYCt2PPOUjrHJ9wFrqpJ3XkgPNOZVfMok7cRw6CSxyCQxXn6ozlESsSh1/sMCTF1rL/g==" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.4.11/jquery.autocomplete.min.js" integrity="sha512-uxCwHf1pRwBJvURAMD/Gg0Kz2F2BymQyXDlTqnayuRyBFE7cisFCh2dSb1HIumZCRHuZikgeqXm8ruUoaxk5tA==" crossorigin="anonymous"></script>
<style>
/* some styles lifted from Bootstrap */
.autocomplete-suggestions { border: 1px solid #222; background: #FFF; overflow: auto; }
.autocomplete-suggestion { cursor: pointer; }
.autocomplete-suggestion, .autocomplete-no-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; color: black; height: calc(1.5em + 0.75rem + 2px); padding: 0.375rem 0.75rem; line-height: 1.5}
.autocomplete-selected { background: #F0F0F0; }
.autocomplete-suggestions strong { color: #50C3F0; }
.autocomplete-group { padding: 2px 5px; }
.autocomplete-group strong { display: block; border-bottom: 1px solid #000; }
</style>
</% block>

<div class="columns is-centered is-mobile">
  <div id="body" class="column" style="max-width: 450px;">
    <div id="header" class="my-1">
      <img id="logo" src="/static/Full-White.svg"/>
      <h1 class="title my-5">2021 Registration</h1>
    </div>

    % for category, msg in get_msgs(with_categories=True):
      <div class="message is-${category}" role="alert">
        <div class="message-body">${msg}</div>
      </div>
    % endfor

    <form method="POST" id="fullForm" action="/" name="payForm">
      <div class="field">
        <label class="label" for="fnameInput">First Name <span class="reqstar">*</span></label>
        <div class="control">
        <input
          type="text"
          class="input"
          id="fnameInput"
          placeholder="Alex"
          name="fname"
          required="required"
        />
        </div>
      </div>
      <div class="field">
        <label class="label" for="lnameInput">Last Name <span class="reqstar">*</span></label>
        <div class="control">
        <input
          type="text"
          class="input"
          id="lnameInput"
          placeholder="Smith"
          name="lname"
          required="required"
        />
        </div>
      </div>
      <div class="field">
        <label class="label" for="emailInput"
          >Email Address <span class="reqstar">*</span></label
        >
        <div class="control">
          <input
            name="email"
            type="email"
            class="input"
            id="emailInput"
            placeholder="a.smith@example.com"
            required="required"
          />
        </div>
        <p class="help">Valid UQ student email formats are:
          <span style="white-space: nowrap;">first.last@uqconnect.edu.au</span>,
          <span style="white-space: nowrap;">first.last@uq.net.au</span>,
          <span style="white-space: nowrap;">s1234567@student.uq.edu.au</span>.
        </p>
      </div>

      <div class="field">
        <label class="label">Gender</label>
        <div class="field is-grouped is-equal-width mb-0">
          <div class="control is-expanded">
            <div class="select wide">
              <select name="gender">
                <option value="">(unspecified)</option>
                <option value="F">Female</option>
                <option value="M">Male</option>
                <option value="NB">Non-binary</option>
                <option value="O">Other</option>
              </select>
            </div>
          </div>
          <div class="control is-expanded">
            <input
              name="gender_text"
              type="text"
              class="input"
              id="gender_text"
              placeholder="(optional extra details)"
            />
          </div>
        </div>
        <p class="help">
          Provinding this information is completely optional.
          We gather aggregate gender statistics only to inform and assess our diversity initiatives.
        </p>
      </div>

      <div class="field mb-4">
        <label class="label">Are you a current UQ student? <span class="reqstar">*</span></label>
        <div class="control">
          <label class="radio">
            <input type="radio" name="student" value="on">
            Yes
          </label>
          <label class="radio">
            <input type="radio" name="student" value="">
            No
          </label>
        </div>
      </div>

      <div id="student-form-section" class="block" style="display: none; opacity: 0;">
        <div class="field">
          <label class="label" for="student-no"
            >Student Number <span class="reqstar">*</span></label
          >
          <input
            type="text"
            name="student-no"
            class="control input"
            id="studentNo"
            placeholder="42345678"
          />
          <p class="help">8 digits, no 's'.</p>
        </div>

        <div class="field">
          <label class="label">Study Details</label>
          <div class="control">
            <label class="radio">
              <input type="radio" name="domORint" value="domestic">
              Domestic
            </label>
            <label class="radio">
              <input type="radio" name="domORint" value="international">
              International
            </label>
          </div>
        </div>

        <div class="field">
          <div class="control">
            <label class="radio">
              <input type="radio" name="degreeType" value="undergrad">
              Undergraduate
            </label>
            <label class="radio">
              <input type="radio" name="degreeType" value="postgrad">
              Postgraduate
            </label>
          </div>
        </div>

        <div class="field">
          <label class="label">Degree&thinsp;/&thinsp;Program</label>
          <input
            type="text"
            id="degreeInput"
            name="degree"
            class="input"
            placeholder="Search keywords, e.g. &quot;comp sci, engineering&quot;"
          />
        </div>


        <div class="field">
          <label class="label">Major(s)</label>
          <input
            type="text"
            id="majorInput"
            name="majorInput"
            class="input control"
            placeholder="Leave blank if undeclared"
          />
        </div>

        <div class="field">
          <label class="label">Year</label>
          <div class="control">
            <div class="select wide">
              <select name="year">
                <option value="">(unspecified)</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5+</option>
              </select>
            </div>
          </div>
        </div>
      </div>

      <!-- First hidden, disabled submit button prevents submission on Enter. -->
      <input type="submit" disabled style="display: none" aria-hidden="true" />

      <div class="field is-grouped is-equal-width">
        <button id="pay-online" type="button" class="control is-expanded button is-link"><b>Pay online</b></button>
        <button id="pay-person" type="button" class="control is-expanded button is-link"><b>Pay in person</b></button>
      </div>

    </form>

    <p class="help">
      Membership is <b>$5</b> for one year.
      Online card payments have a <b>40c</b> surcharge.
      In person card payments have a <b>10c</b> surcharge.
    </p>
    <p class="help">
      Membership expires at the end of February of the <i>next</i> calendar year
      (${expiry_today}).
      <!-- Membership purchased from ${start_future} will expire on ${expiry_future}. -->
    </p>
  </div>
</div>
<script src="/static/form.js"></script>
<script>
setupForm("${STRIPE_PUBLIC_KEY}", "${STRIPE_PRICE_ID}");
setupAutocomplete();
</script>
