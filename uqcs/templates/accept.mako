<%inherit file="base.mako"/>

<div id="body">
<h1 class="title">Unpaid Members</h1>
<div class="buttons">
<button class="button is-link" onclick="window.location.reload()">Refresh</button>
<a href="/admin/list" class="button is-link">List</a>
</div>

<table class="table is-fullwidth is-striped" id="unpaid-members">
<thead>
<tr>
<th>First Name</th>
<th>Last Name</th>
<th>Email</th>
<th>Payment Method</th>
<th>Delete</th>
</tr>
</thead>
<tbody>
% for member in members:
<tr>
<td>${member.first_name}</td>
<td>${member.last_name}</td>
<td>${member.email}</td>
<td>
  <a href="/admin/paid/${member.id}?payment=CASH" class="button is-link mr-2">&#x1f4b2; Cash</a>
  <a href="/admin/paid/${member.id}?payment=SQUARE" class="button is-link mr-2">&#x1f4b3; Square</a>
  <a href="/admin/paid/${member.id}?payment=UQU" class="button is-link">&#x1F3AB; UQU</a>
</td>
<td><a href="/admin/delete/${member.id}" class="button is-danger">Delete</a></td>
</tr>
%endfor
</tbody>
</table>
</div>