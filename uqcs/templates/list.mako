<%inherit file="base.mako"/>

<div id="body">
<h1 class="title">All Members</h1>
<div class="buttons">
<button class="button is-link" onclick="window.location.reload()">Refresh</button>
<a href="/admin/accept" class="button is-link">Unpaid</a>
</div>

<p class="my-4">
  Registered: ${members.count()}<br/>
  Paid: ${paid.count()}
</p>

<div class="buttons">
<a href="/admin/dump_members" class="button is-link">Dump Members</a>
</div>

<table class="table is-fullwidth is-narrow is-striped">
<thead>
<tr>
<th>First Name</th>
<th>Last Name</th>
<th>Email</th>
<th>Paid</th>
</tr>
</thead>
<tbody>
% for member in members:
<tr>
<td>${member.first_name}</td>
<td>${member.last_name}</td>
<td>${member.email}</td>
<td>${str(member.paid)}</td>
</tr>
%endfor
</tbody>
</table>
</div>