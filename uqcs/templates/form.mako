<%inherit file="base.mako"/>

<%block name="head_extra">

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
        <div class="control">
          <div class="select wide">
            <select name="gender">
              <option value="">(unspecified)</option>
              <option value="M">Male</option>
              <option value="F">Female</option>
              ## <option value="NB">Non-binary</option>
              ## <option value="O">Other</option>
            </select>
          </div>
        </div>
      </div>

      <div class="field">
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

      <div id="student-form-section" class="block" style="display: none;">
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
            name="degreeInput"
            class="input control"
            placeholder="Search keywords, e.g. &quot;comp sci, engineering&quot;"
          />
        </div>

        <div class="field">
          <label class="label">Major</label>
          <input
            type="text"
            id="majorInput"
            name="majorInput"
            class="input control"
            placeholder="Leave blank if undeclared"
          />
        </div>
        <input type="hidden" id="degree" name="degree">

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

      <!-- This hidden button is clicked after successful form validation. -->
      <input
        type="submit"
        id="submit"
        style="display:none;"
      />

      <!-- Used to communicate payment method to server. Set in Javascript. -->
      <input
        type="text"
        id="payment-method"
        name="paymentMethod"
        style="display: none;"
      />

      <div class="buttons wide mb-1">
        <button id="pay-online" type="button" class="button is-link"><b>Pay online</b></button>
        <button id="pay-person" type="button" class="button is-link"><b>Pay in person</b></button>
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
setupForm();
setupAutocomplete();
</script>
