import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.context.support.WebApplicationContextUtils;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

/**
 * Servlet for generating asset reports with graphs.
 */
public class ReportsModel extends HttpServlet {
    private JdbcTemplate jdbcTemplate;

    @Override
    public void init() throws ServletException {
        ApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
        jdbcTemplate = (JdbcTemplate) context.getBean("jdbcTemplate");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session =request.getSession();
        try {
            // Get the filtered status from request
            String statusFilter = request.getParameter("status");
            String sql;
            List<Map<String, Object>> assetsList;

            // Check if status filter is applied
            if (statusFilter != null && !statusFilter.isEmpty()) {
                sql = "SELECT * FROM assets WHERE status = ? ORDER BY updated_at DESC";
                assetsList = jdbcTemplate.queryForList(sql, statusFilter);
            } else {
                // Fetch all assets if no filter is applied
                sql = "SELECT * FROM assets ORDER BY updated_at DESC";
                assetsList = jdbcTemplate.queryForList(sql);
            }

            // Query to get the count of active and inactive assets
            String activeCountSql = "SELECT COUNT(*) FROM assets WHERE status = 'active'";
            String inactiveCountSql = "SELECT COUNT(*) FROM assets WHERE status = 'inactive'";
            String soldCountSql = "SELECT COUNT(*) FROM assets WHERE status = 'sold'";
            String damagedCountSql = "SELECT COUNT(*) FROM assets WHERE status = 'damaged'";
            int activeCount = jdbcTemplate.queryForObject(activeCountSql, Integer.class);
            int inactiveCount = jdbcTemplate.queryForObject(inactiveCountSql, Integer.class);
            int soldCount = jdbcTemplate.queryForObject(soldCountSql, Integer.class);
            int damagedCount = jdbcTemplate.queryForObject(damagedCountSql, Integer.class);

            // Set attributes to be passed to the JSP
            request.setAttribute("assets", assetsList);
            request.setAttribute("activeCount", activeCount);
            request.setAttribute("inactiveCount", inactiveCount);
            request.setAttribute("soldCount", soldCount);
            request.setAttribute("damagedCount", damagedCount);
            // Forward to the reports JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher((String)session.getAttribute("level")+"_reports.htm");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("a_reports.htm");
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
        return "Servlet for generating reports with asset status graphs";
    }
}
