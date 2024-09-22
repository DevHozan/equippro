<%@include file="header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js -->

<body class=" container ms-4 " style="margin-left: 20%">
    <div class="container ms-4">
        <h2 class="text-center text-primary">Assets Reports</h2>

        <!-- Filter Form -->
        <form action="ReportsModel" method="GET" class="form-inline mb-3">
            <label for="status" class="mr-2">Filter by status:</label>
            <select name="status" id="status" class="form-control mr-3">
                <option value="">All</option>
                <option value="active">Active</option>
                <option value="inactive">Inactive</option>
                <option value="sold">Sold</option>
                <option value="damaged">Damaged</option>
            </select>
            <input type="submit" value="Filter" class="btn btn-primary">
        </form>

        <!-- Assets Table -->
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Asset Name</th>
                    <th>Asset Type</th>
                    <th>Purchase Date</th>
                    <th>Purchase Price</th>
                    <th>Location</th>
                    <th>Status</th>
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
                        <td>${asset.location}</td>
                        <td>${asset.status}</td>
                        <td>${asset.updated_at}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- No Assets Found Message -->
        <c:if test="${empty assets}">
            <p class="text-center text-danger">No assets found.</p>
        </c:if>

        <!-- Asset Status Distribution Graph -->
        <div class="mt-5">
            <h4 class="text-center">Asset Status Distribution</h4>
            <canvas id="assetsChart" width="400" height="200"></canvas>
        </div>
    </div>

    <script>
        // Data passed from the servlet (example: hardcoded for illustration purposes)
        const labels = ['Active', 'Inactive','damaged','sold']; // Asset statuses
        const data = {
            labels: labels,
            datasets: [{
                label: 'Number of Assets',
                data: [${activeCount}, ${inactiveCount}, ${damagedCount}, ${soldCount}], // Data passed from the servlet
                backgroundColor: [
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(255, 99, 132, 0.2)',
                ],
                borderColor: [
                    'rgba(75, 192, 192, 1)',
                    'rgba(255, 99, 132, 1)',
                ],
                borderWidth: 1
            }]
        };

        const config = {
            type: 'bar',
            data: data,
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        };

        // Render the chart
        var myChart = new Chart(
            document.getElementById('assetsChart'),
            config
        );
    </script>
</body>
</html>
