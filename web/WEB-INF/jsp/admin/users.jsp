<%@include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Main Content -->
<div class="content">
    <h2>Users</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card text-white bg-primary mb-3">
                <div class="card-body">
                    <h5 class="card-title">Total Users</h5>
                    <p class="card-text">Manage all users in the system.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card text-white bg-success mb-3">
                <div class="card-body">
                    <h5 class="card-title">Active Assets</h5>
                    <p class="card-text">Track active equipment and assets.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Reports Section -->
    <h4>Users in The System</h4>
    <button class="btn btn-secondary" id="add_user">ADD USER</button>
    <div class="add_u" style="display:none;">
        <fieldset class="col-lg-6 m-3">
            <legend class="text-primary bg-primary">Register Form</legend>
            <form action="UsersModel" method="GET">
                <input type="hidden" name="action" value="Add">
                <input type="text" name="names" class="form-control" placeholder="Type user names" required> <br>
                <input type="email" name="email" class="form-control" placeholder="Type user emails" required> <br>
                <input type="tel" name="tel" class="form-control" placeholder="Type user telephone" required> <br>
                <select name="level" class="form-control" required>
                    <option value="">---select level of user---</option>
                    <option value="admin">Admin</option>
                    <option value="manager">Manager</option>
                    <option value="technician">Technician</option>
                    <option value="accountant">Accountant</option>
                    <option value="vendor">Vendor</option>
                    <option value="auditor">Auditor</option>
                </select>
                <br>
                <input type="password" name="password" class="form-control" placeholder="Type user password" required> <br>
                <input type="submit" class="btn btn-primary" value="Add">
            </form>
            <p class="text-danger">
                <% 
                    if (session.getAttribute("message") != null) { 
                        out.print(session.getAttribute("message")); 
                        session.removeAttribute("message"); 
                    }
                %>
            </p>
        </fieldset>
    </div>

    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Names</th>
                <th>Email</th>
                <th>Tel</th>
                <th>Level</th>
                <th>Status</th>
                <th>Action</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.names}</td>
                    <td>${user.email}</td>
                    <td>${user.tel}</td>
                    <td>${user.level}</td>
                    <td>${user.status}</td>
                    <td>
                        <form method="GET" action="UsersModel">
                            <input type="hidden" name="user_id" value="${user.id}">
                           
                            <input type="submit" class="btn btn-primary" name="action" value="Activate">
                     
                            <input type="submit" class="btn btn-danger" name="action" value="Deactivate">
                        </form>
                    </td>
                    <td>${user.date}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
    document.getElementById("add_user").addEventListener("click", function () {
        document.querySelector(".add_u").style.display = "block";
    });
</script>

<%@include file="footer.jsp" %>
