<%inherit file="base.mako"/>

<div class="row">
<div id="body" class="col-md-12">
<h1>Unpaid Members</h1>
<p><a href="#" class="btn btn-warning" onclick="window.location.reload()">Refresh</a></p>
<table class="table table-hover" id="unpaid-members">
<thead>
<tr>
<th>First Name</th>
<th>Last Name</th>
<th>Email</th>
<th></th>
<th></th>
</tr>
</thead>
<tbody>
% for member in members:
<tr>
<td>${member.first_name}</td>
<td>${member.last_name}</td>
<td>${member.email}</td>
<td>
  <a href="/admin/paid/${member.id}?payment=CASH" class="btn btn-success mr-4">&#x1f4b2; Paid Cash</a>
  <a href="/admin/paid/${member.id}?payment=SQUARE" class="btn btn-info">&#x1f4b3; Paid Square</a>
</td>
<td><a href="/admin/delete/${member.id}" class="btn btn-danger">Delete</a></td>
</tr>
%endfor
</tbody>
</table>
</div>
</div>