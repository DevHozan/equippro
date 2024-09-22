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

public class ReplacementModel extends HttpServlet {
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
                String replacementDate = request.getParameter("replacement_date");
                String details = request.getParameter("details");
                String cost = request.getParameter("cost");

                String sqlInsert = "INSERT INTO replacements (asset_id, replacement_date, details, cost) VALUES (?, ?, ?, ?)";
                jdbcTemplate.update(sqlInsert, assetId, replacementDate, details, cost);
                session.setAttribute("message", "Replacement record added successfully.");
            }

            if ("Delete".equals(action)) {
                String replacementId = request.getParameter("replacement_id");
                String sqlDelete = "DELETE FROM replacements WHERE replacement_id = ?";
                jdbcTemplate.update(sqlDelete, replacementId);
                session.setAttribute("message", "Replacement record deleted successfully.");
            }

            if ("Done".equals(action)) {
                String replacementId = request.getParameter("replacement_id");
                String sqlDelete = "DELETE FROM replacements WHERE replacement_id = ?";
                jdbcTemplate.update(sqlDelete, replacementId);

                String assetId = request.getParameter("asset_id");
                String status = "active";

                // Get the current date
                Date date = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = sdf.format(date);

                String sqlUpdate = "UPDATE assets SET status = ?, last_replacement_date = ? WHERE asset_id = ?";
                jdbcTemplate.update(sqlUpdate, status, formattedDate, assetId);

                session.setAttribute("message", "Replacement completed successfully.");
            }

            // Querying replacement records
            String sql = "SELECT r.*, a.asset_name FROM replacements r " +
                         "JOIN assets a ON r.asset_id = a.asset_id";
            List<Map<String, Object>> replacementList = jdbcTemplate.queryForList(sql);
            request.setAttribute("replacementRecords", replacementList);

            // Querying assets for the dropdown
            List<Map<String, Object>> assetsList = jdbcTemplate.queryForList("SELECT * FROM assets WHERE status = 'Activate' OR status = 'Damaged'");
            request.setAttribute("assets", assetsList);

            RequestDispatcher dispatcher = request.getRequestDispatcher((String)session.getAttribute("level")+"_replacement_management.htm");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error_page.jsp");
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
        return "Replacement Model Servlet for managing asset replacement records";
    }
}
