<%inherit file="base.mako"/>

<div class="columns is-centered">
  <div id="body" class="column is-half">
    % for category, msg in get_msgs(with_categories=True):
      <div class="message is-${category}" role="alert">
        <div class="message-body">${msg}</div>
      </div>
    % endfor
    <form method="POST">
      <div class="field">
        <label class="label" for="username">Username<span class="reqstar">*</span></label>
        <input type="text" class="input" name="username" placeholder="Username" required="true">
      </div>
      <div class="field">
        <label class="label" for="password">Password<span class="reqstar">*</span></label>
        <input type="password" class="input" name="password" placeholder="Password" required="true">
      </div>
      <input class="button is-link" name="submit" type="submit" value="Submit">
    </form>
  </div>
</div>