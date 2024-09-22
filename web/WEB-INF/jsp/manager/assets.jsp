<%@include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Main Content -->
<div class="content">
    <h2>Assets</h2>
    <div class="row">
        <div class="col-md-4">
            <div class="card text-white bg-primary mb-3">
              
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
    <button class="btn btn-secondary" id="add_assets">ADD Assets</button>
    <div class="add_u" style="display:none">
    
          
           <div class="add_asset">
    <fieldset class="col-lg-9 m-3">
        <legend class="text-white bg-primary">Record Asset Form</legend>
        <form action="AssetsModel" method="GET">
            <input type="hidden" name="action" value="Add">
            
            <input type="text" name="asset_name" class="form-control" placeholder="Type asset name" required> <br>
            <input type="text" name="asset_type" class="form-control" placeholder="Type asset type" required> <br>
            
            <input type="date" name="purchase_date" class="form-control" placeholder="Select purchase date" required> <br>
            <input type="number" step="0.01" name="purchase_price" class="form-control" placeholder="Enter purchase price" required> <br>
            
            <input type="text" name="location" class="form-control" placeholder="Enter asset location" required> <br>
            <textarea name="description" class="form-control" placeholder="Enter asset description" required></textarea> <br>
            
            <input type="number" step="0.01" name="depreciation_rate" class="form-control" placeholder="Depreciation rate (%)"> <br>
            
            <input type="submit" class="btn btn-primary" value="Add Asset">
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
    </div>

<!-- Table to display assets -->
<table class="table table-bordered">
    <thead>
        <tr>
            <th>Asset Name</th>
            <th>Asset Type</th>
            <th>Purchase Date</th>
            <th>Purchase Price</th>
            <th>Depreciation rate /year</th>
            <th>Location</th>
            <th>Status</th>
            <th>Action</th>
            <th>Last Updated</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="asset" items="${assets}">
            <tr>
                <td>${asset.asset_name}</td>
                <td>${asset.asset_type}</td>
                <td>${asset.purchase_date}</td>
                <td>${asset.purchase_price}</td>
                <td>${asset.depreciation_rate}%</td>
                <td>${asset.location}</td>
                <td>${asset.status}</td>
                <td>
                    <form method="GET" action="AssetsModel">
                        <input type="hidden" name="asset_id" value="${asset.asset_id}">
                        
                        <input type="submit" class="btn btn-primary" name="action" value="Activate">
                        
                        <input type="submit" class="btn btn-danger" name="action" value="Deactivate">
                        
                        <input type="submit" class="btn btn-secondary" name="action" value="Damaged"><!-- comment -->
                        <input type="submit" class="btn btn-info" name="action" value="Sold">
                    </form>
                </td>
                <td>${asset.updated_at}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<script>
    document.getElementById("add_assets").addEventListener("click", function () {
        document.querySelector(".add_u").style.display = "block";
    });
</script>

<%@include file="footer.jsp" %>
