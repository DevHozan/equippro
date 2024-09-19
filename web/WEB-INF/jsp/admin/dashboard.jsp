<%@include file="header.jsp" %>
    <!-- Main Content -->
    <div class="content">
        <h2>Dashboard</h2>
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
            <div class="col-md-4">
                <div class="card text-white bg-danger mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Pending Maintenance</h5>
                        <p class="card-text">View upcoming maintenance tasks.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reports Section -->
        <h4>Recent Reports</h4>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Report ID</th>
                    <th>Asset</th>
                    <th>Status</th>
                    <th>Date</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>001</td>
                    <td>Generator</td>
                    <td><span class="badge badge-success">Completed</span></td>
                    <td>2024-09-18</td>
                </tr>
                <tr>
                    <td>002</td>
                    <td>Cooling Unit</td>
                    <td><span class="badge badge-warning">In Progress</span></td>
                    <td>2024-09-18</td>
                </tr>
                <tr>
                    <td>003</td>
                    <td>AC System</td>
                    <td><span class="badge badge-danger">Pending</span></td>
                    <td>2024-09-19</td>
                </tr>
            </tbody>
        </table>
    </div>

 
<%@include file="footer.jsp" %>