// Used on form.mako

// helper functions
/** @type {function(string): HTMLElement} */
const $ = (x) => document.querySelector(x);
/** @type {function(string): NodeListOf<HTMLElement>} */
const $$ = (x) => document.querySelectorAll(x);


function validId(id) {
  if (id.length !== 8) {
    return false;
  }

  const validFormat = RegExp(/[1-5][0-9]{7}$/).test(id);

  let x = 0;
  const digitMultipliers = [9, 7, 3, 9, 7, 3, 9];
  digitMultipliers.forEach((mult, i) => x += mult * parseInt(id[i]));
  const validValue = x % 10 === parseInt(id[7]);

  return validFormat && validValue;
}

function _deleteElement(el) {
  el.parentElement.removeChild(el);
}

function _deleteParent(el) {
  _deleteElement(el.parentElement)
}

function showFormErrors(messages) {
  const header = $('#header');

  $$('.notification').forEach(_deleteElement);

  for (const msg of messages) {
    const template = `
    <div class="notification is-danger is-light is-small">
      <button class="delete" onclick="_deleteParent(this)"></button>
      ${msg}
    </div>`;
    const fragment = document.createRange().createContextualFragment(template);
    header.insertAdjacentElement('afterend', fragment.firstElementChild);
  }
}

function setupForm(stripePublicKey, stripePriceId) {
  if (!stripePublicKey || !stripePriceId) {
    console.warn('Missing Stripe public key or price ID.');
  }

  $$("input[name=student]").forEach(el => el.addEventListener('change', function (e) {
    const studentForm = $("#student-form-section");
    /** @type {HTMLInputElement} */
    const studentNo = $("#studentNo");

    if (this.value === "on") {
      studentNo.required = true;
      studentForm.style.display = null;
      setTimeout(() => studentForm.style.opacity = 1, 0);
    } else {
      studentNo.required = false;
      studentForm.style.opacity = 0;
      setTimeout(() => studentForm.style.display = 'none', 250);
    }
  }));

  function checkId() {
    let field = document.getElementById("studentNo");
    let id = document.getElementById("studentNo").value;
    if (validId(id)) {
      field.setCustomValidity("");
    } else {
      let text = "Invalid student number.";
      if (id.length != 8)
        text = text + " Must be 8 digits.";
      field.setCustomValidity(text);
    }
  }

  document.getElementById("studentNo").onchange = checkId;

  const form = $('#fullForm');
  $$('#pay-online, #pay-person').forEach(el => el.addEventListener('click', async () => {
    if (!form.checkValidity()) {
      form.reportValidity();
      return;
    }

    const data = new FormData(form);
    const req = await fetch('/', { method: 'POST', body: data });
    if (!req.ok) {
      showFormErrors([`Server error: ${req.status} ${req.statusText}`]);
      return;
    }

    const resp = await req.json();
    if (resp.errors) {
      showFormErrors(resp.errors);
      return;
    }

    const paymentMethod = el.id == 'pay-online' ? 'online' : 'person';
    if (paymentMethod === 'person') {
      window.location.href = '/complete';
    } else {
      const stripe = Stripe(stripePublicKey);
      const origin = window.location.origin;

      stripe.redirectToCheckout({
        lineItems: [{
          price: stripePriceId,
          quantity: 1,
        }],
        customerEmail: resp.email,
        mode: 'payment',
        successUrl: origin + '/complete?session={{CHECKOUT_SESSION_ID}}',
        cancelUrl: origin,
      });
    }
  }));
}


function initAutocomplete(inputElement) {
  return inputElement.autocomplete({
    lookup: [],
    autoSelectFirst: true,
    // orientation: 'auto',
    showNoSuggestionNotice: true,
    noSuggestionNotice: 'No suggestions, please enter manually.',
    lookupLimit: 10,
    lookupFilter: function (suggestion, query, queryLowerCase) {
      const s = suggestion.value.toLowerCase();
      // split by space, remove non-alpha, to get tokens.
      // then filters out tokens which DO appear in this suggestion.
      return queryLowerCase.split(' ')
        .map(q => q.replace(/[^a-z]/g, ''))
        .filter(q => q.length && s.indexOf(q) == -1).length == 0;
    },
    onSelect: function (suggestion) {
      inputElement.val(suggestion.value);
    },
  }).autocomplete();
};

async function setupAutocomplete() {
  // init autocomplete
  const $degreeInput = jQuery('#degreeInput');
  const $degreeAutocomplete = initAutocomplete($degreeInput);

  const majorInput = $('#majorInput');
  const $majorInput = jQuery(majorInput);
  const $majorAutocomplete = initAutocomplete($majorInput);

  // load autocomplete data
  const data = await fetch('/static/programs_with_majors.json')
    .then(response => {
      // check for HTTP error response codes.
      if (!response.ok) throw new Error('error loading degrees: ' + response.statusText);
      return response.json();
    })
    .catch(error => {
      // hide help text if loading failed.
      $degreeInput.attr('placeholder', '');
      throw error;
    });

  const allData = {
    ...data.undergrad,
    ...data.postgrad,
  };

  const allMajors = Array.from(new Set(Object.values(data).map(Object.values).flat(2))).sort();

  $$("input[name=degreeType]").forEach(el => el.addEventListener('change', function(e) {
    const lookup = [];
    if (this.value === 'undergrad')
      lookup.push(...Object.keys(data.undergrad));
    if (this.value === 'postgrad')
      lookup.push(...Object.keys(data.postgrad));
    $degreeAutocomplete.setOptions({lookup})
  }));

  $degreeInput.change(function(e) {
    const lookup = allData[this.value] || allMajors;
    $majorAutocomplete.setOptions({lookup})
  });

  $degreeAutocomplete.setOptions({lookup: [...Object.keys(data.undergrad), ...Object.keys(data.postgrad)]});
  $majorAutocomplete.setOptions({lookup: allMajors});


  function addMajor(major) {
    major = major.trim();
    if (!major) return;
    document.querySelectorAll(`input[name="majors[]"][value="${major}"]`)
      .forEach(_deleteParent);

    const template = `
    <div class="field has-addons">
      <input class="input control is-expanded" readonly name="majors[]" value="${major}"/>
      <button class="control button" type="button">&times;</button>
    </div>
    `;
    const fragment = document.createRange().createContextualFragment(template);

    const el = majorInput.insertAdjacentElement('beforebegin', fragment.firstElementChild);
    el.querySelector('button').addEventListener('click', () => _deleteElement(el));
  }

  function addMajorAndClear(value) {
    addMajor(typeof value === 'string' ? value : majorInput.value);
    majorInput.value = '';
  }

  $majorAutocomplete.setOptions({
    onSelect: (suggestion) => addMajorAndClear(suggestion.value),
  });

  majorInput.addEventListener('blur', addMajorAndClear);
  majorInput.addEventListener('keyup', (ev) => ev.key === 'Enter' && addMajorAndClear());

  // hack because autocomplete library does not handle touchpad clicks properly.
  jQuery('.autocomplete-suggestions').on('pointerdown', (ev) => {
    $majorAutocomplete.select(ev.target.dataset.index);
  });
};
