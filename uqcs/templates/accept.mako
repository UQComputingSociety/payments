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
  <a href="/admin/paid/${member.id}?payment=CASH" class="btn btn-success my-1 mr-1">&#x1f4b2; Cash</a>
  <a href="/admin/paid/${member.id}?payment=SQUARE" class="btn btn-info my-1 mr-1">&#x1f4b3; Square</a>
  <a href="/admin/paid/${member.id}?payment=UQU" class="btn btn-primary my-1">&#x1F3AB; UQU</a>
</td>
<td><a href="/admin/delete/${member.id}" class="btn btn-danger">Delete</a></td>
</tr>
%endfor
</tbody>
</table>
</div>
</div>