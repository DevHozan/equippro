<%@ include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="content">
    <h2>Asset Replacement Management</h2>
    
    <button class="btn btn-secondary" id="add_replacement">Add Replacement Request</button>
    <div class="add_m" style="display:none">
      <fieldset class="col-lg-11 m-3">
            <legend class="text-white bg-primary">Add Replacement Record</legend>
            <form action="ReplacementModel" method="GET">
                <input type="hidden" name="action" value="Add">
                <select name="asset_id" class="form-control" required>
                    <option value="">Select Asset</option>
                    <c:forEach var="asset" items="${assets}">
                        <option value="${asset.asset_id}">${asset.asset_name}</option>
                    </c:forEach>
                </select><br>
                <input type="date" name="replacement_date" class="form-control" required><br>
                <textarea name="details" class="form-control" placeholder="Replacement Details" required></textarea><br>
                <input type="number" name="cost" class="form-control" placeholder="Cost" required step="0.01"><br>
                <input type="submit" class="btn btn-primary" value="Add Replacement">
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
    
    <!-- Table to display replacement records -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Asset</th>
                <th>Replacement Date</th>
                <th>Details</th>
                <th>Cost</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="replacement" items="${replacementRecords}">
                <tr>
                    <td>${replacement.asset_name}</td>
                    <td>${replacement.replacement_date}</td>
                    <td>${replacement.details}</td>
                    <td>${replacement.cost}</td>
                    <td>
                        <form method="GET" action="ReplacementModel">
                            <input type="hidden" name="replacement_id" value="${replacement.replacement_id}">
                            <input type="hidden" name="asset_id" value="${replacement.asset_id}">

                            <input type="submit" class="btn btn-primary" name="action" value="Done">
                            <input type="submit" class="btn btn-danger" name="action" value="Delete">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <script>
        document.getElementById("add_replacement").addEventListener("click", function () {
            document.querySelector(".add_m").style.display = "block";
        });
    </script>
</div>

<%@ include file="footer.jsp" %>
