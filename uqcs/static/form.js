// Used on form.mako

// helper functions
/** @type {function(string): HTMLElement} */
const $ = (x) => document.querySelector(x);
/** @type {function(string): NodeListOf<HTMLElement>} */
const $$ = (x) => document.querySelectorAll(x);

const STRIPE_PUBLIC_KEY = "${STRIPE_PUBLIC_KEY}";

function setupStripe() {
  var handler = StripeCheckout.configure({
    key: STRIPE_PUBLIC_KEY,
    locale: "auto",
    token: function (token) {
      $("#stripeToken").value = token.id;
      $("#submitbtn").click();
    },
  });

  $("#payonline_submit").addEventListener("click", function (e) {
    e.preventDefault();
    var form = $("#fullForm");
    if (!form.checkValidity()) {
      form.reportValidity();
      return;
    }
    handler.open({
      name: "UQCS",
      description: "2020 Membership",
      currency: "aud",
      amount: 540,
      email: $("#emailInput").value,
    });
  });

  window.addEventListener('popstate', function () {
    handler.close();
  });
}


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

function setupForm() {
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

  document.getElementById("studentNo").onchange = checkId;
}

const TEST_WORDS = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.".split(/\s+/);


function setupAutocomplete() {
  new autoComplete({
    data: {
      src: TEST_WORDS.map(x => ({value: x, label: x})),
      key: ['value'],
    },
    selector: '#test',
    observer: true,
  });
}

// setupStripe();
setupForm();
setupAutocomplete();