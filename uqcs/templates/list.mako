<%inherit file="base.mako"/>

<div class="row">
<div id="body" class="col-md-12">
<h1> All Members</h1>
<p><a href="#" class="btn btn-warning" onclick="window.location.reload()">Refresh</a></p>
<p>Registered: ${members.count()}<br/>Paid: ${paid.count()}</p>
<table class="table table-hover table-sm">
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
</div>