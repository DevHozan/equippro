<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="content">
    <h2>Asset Maintenance Management</h2>
    
    <button class="btn btn-secondary" id="add_maintenance">Add Maintenance Record</button>
    <div class="add_m" style="display:none">
        <fieldset class="col-lg-11 m-3">
            <legend class="text-white bg-primary">Add Maintenance Record</legend>
            <form action="MaintenanceModel" method="GET">
                <input type="hidden" name="action" value="Add">
                <select name="asset_id" class="form-control" required>
                    <option value="">Select Asset</option>
                    <c:forEach var="asset" items="${assets}">
                        <option value="${asset.asset_id}">${asset.asset_name}</option>
                    </c:forEach>
                </select><br>
                <input type="date" name="maintenance_date" class="form-control" required><br>
                <textarea name="details" class="form-control" placeholder="Maintenance Details" required></textarea><br>
                <input type="number" name="cost" class="form-control" placeholder="Cost" required step="0.01"><br>
                <input type="submit" class="btn btn-primary" value="Add Maintenance">
            </form>
           
        </fieldset>
    </div>
 <p class="text-danger">
                <% 
                    if (session.getAttribute("message") != null) { 
                        out.print(session.getAttribute("message")); 
                        session.removeAttribute("message"); 
                    }
                %>
            </p>
    <!-- Table to display maintenance records -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Asset</th>
                <th>Maintenance Date</th>
                <th>Details</th>
                <th>Cost</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="maintenance" items="${maintenanceRecords}">
                <tr>
                    <td>${maintenance.asset_name}</td>
                    <td>${maintenance.maintenance_date}</td>
                    <td>${maintenance.details}</td>
                    <td>${maintenance.cost}</td>
                    <td>
                        <form method="GET" action="MaintenanceModel">
                            <input type="hidden" name="maintenance_id" value="${maintenance.maintenance_id}">
                            <input type="hidden" name="asset_id" value="${maintenance.asset_id}">

                            <input type="submit" class="btn btn-primary" name="action" value="Done">
                            <input type="submit" class="btn btn-danger" name="action" value="Delete">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <script>
        document.getElementById("add_maintenance").addEventListener("click", function () {
            document.querySelector(".add_m").style.display = "block";
        });
    </script>
</div>

<%@ include file="footer.jsp" %>
