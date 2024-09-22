import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.context.support.WebApplicationContextUtils;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;

public class MaintenanceModel extends HttpServlet {
    private JdbcTemplate jdbcTemplate;

    @Override
    public void init() throws ServletException {
        ApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
        jdbcTemplate = (JdbcTemplate) context.getBean("jdbcTemplate");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String action = request.getParameter("action");

            if ("Add".equals(action)) {
                String assetId = request.getParameter("asset_id");
                String maintenanceDate = request.getParameter("maintenance_date");
                String details = request.getParameter("details");
                String cost = request.getParameter("cost");

                String sqlInsert = "INSERT INTO maintenance (asset_id, maintenance_date, details, cost) VALUES (?, ?, ?, ?)";
                jdbcTemplate.update(sqlInsert, assetId, maintenanceDate, details, cost);
                session.setAttribute("message", "Maintenance record added successfully.");
            }

            if ("Delete".equals(action)) {
                String maintenanceId = request.getParameter("maintenance_id");
                String sqlDelete = "DELETE FROM maintenance WHERE maintenance_id = ?";
                jdbcTemplate.update(sqlDelete, maintenanceId);
                session.setAttribute("message", "Maintenance record deleted successfully.");
            }
            if("Done".equals(action)){
                   String maintenanceId = request.getParameter("maintenance_id");
                String sqlDelete = "DELETE FROM maintenance WHERE maintenance_id = ?";
                jdbcTemplate.update(sqlDelete, maintenanceId);
                
                  String assetId = request.getParameter("asset_id");
                String status = "active";
                   // Get the current date
                            Date date = new Date();

                            // Define the desired date format
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                            // Format the current date
                            String formattedDate = sdf.format(date);
              
                
                String sqlUpdate = "UPDATE assets SET status = ? ,last_maintenance_date=? WHERE asset_id = ?";
                jdbcTemplate.update(sqlUpdate, status, formattedDate, assetId);
                 session.setAttribute("message", "Maintenance done successfully.");
            }

            // Querying maintenance records
            String sql = "SELECT m.*, a.asset_name FROM maintenance m " +
                         "JOIN assets a ON m.asset_id = a.asset_id";
            List<Map<String, Object>> maintenanceList = jdbcTemplate.queryForList(sql);
            request.setAttribute("maintenanceRecords", maintenanceList);

            // Querying assets for the dropdown
            List<Map<String, Object>> assetsList = jdbcTemplate.queryForList("SELECT * FROM assets WHERE status = 'Activate' or status= 'damaged'");
            request.setAttribute("assets", assetsList);

            RequestDispatcher dispatcher = request.getRequestDispatcher((String)session.getAttribute("level")+"_maintenance_management.htm");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error_page.htm");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Maintenance Model Servlet for managing asset maintenance records";
    }
}
