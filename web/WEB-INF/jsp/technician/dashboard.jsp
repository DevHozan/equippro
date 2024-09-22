<%@include file="header.jsp" %>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Include Chart.js -->
    <!-- Main Content -->
    <div class="content">
        <h2>Dashboard</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Total Users ${activUsersCount}</h5>
                        <p class="card-text">Manage all users in the system.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Active Assets ${activeCount}</h5>
                        <p class="card-text">Track active equipment and assets.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-white bg-danger mb-3">
                    <div class="card-body">
                        <h5 class="card-title">Pending Maintenance ${maintenanceCount}</h5>
                        <p class="card-text">View upcoming maintenance tasks.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Reports Section -->
      
        
<div class="mt-5">
            <h4 class="text-center">Reports</h4>
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
    </div>

 
<%@include file="footer.jsp" %>