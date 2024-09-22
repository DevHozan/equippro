import java.io.IOException;
import java.io.PrintWriter;
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

/**
 * Assets Model Servlet to manage asset data.
 *
 * @author Hozana
 */
public class AssetsModel extends HttpServlet {
    private JdbcTemplate jdbcTemplate;

    @Override
    public void init() throws ServletException {
        // Obtain the Spring application context and JdbcTemplate bean
        ApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
        jdbcTemplate = (JdbcTemplate) context.getBean("jdbcTemplate");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String action = request.getParameter("action");
          

            // Handling Activate and Deactivate actions
            if ("Activate".equals(action) || "Deactivate".equals(action)|| "Damaged".equals(action) || "Sold".equals(action)) {
                  String assetId = request.getParameter("asset_id");
                String status = action;
                String sqlUpdate = "UPDATE assets SET status = ? WHERE asset_id = ?";
                jdbcTemplate.update(sqlUpdate, status, assetId);

//                RequestDispatcher dispatcher = request.getRequestDispatcher("a_assets.jsp");
//                dispatcher.forward(request, response);
            }
            
            if ("Add".equals(action)) {
                String assetName = request.getParameter("asset_name");
                String assetType = request.getParameter("asset_type");
                String purchaseDate = request.getParameter("purchase_date");
                String purchasePrice = request.getParameter("purchase_price");
                String location = request.getParameter("location");
                String description = request.getParameter("description");
                String depreciationRate = request.getParameter("depreciation_rate");
                String status = "active"; // Default status when adding a new asset

                // SQL Insert statement for assets
                String sqlInsert = "INSERT INTO assets (asset_name, asset_type, purchase_date, purchase_price, location, description, depreciation_rate, status) "
                                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                // Execute the insertion query
                jdbcTemplate.update(sqlInsert, assetName, assetType, purchaseDate, purchasePrice, location, description, depreciationRate, status);

                // Optional: Set a success message in the session or redirect accordingly
                session.setAttribute("message", "Asset added successfully.");
            }

            // Querying the assets list
            String sql = "SELECT * FROM assets ORDER BY updated_at DESC";
            List<Map<String, Object>> assetsList = jdbcTemplate.queryForList(sql);

            // If assets found, forward to assets page, otherwise show no assets page
            if (assetsList != null && !assetsList.isEmpty()) {
                request.setAttribute("assets", assetsList);
                RequestDispatcher dispatcher = request.getRequestDispatcher((String)session.getAttribute("level")+"_assets.htm");
                dispatcher.forward(request, response);
            } else {
                out.println("<p>No assets found in the system.</p>");
                RequestDispatcher dispatcher = request.getRequestDispatcher((String)session.getAttribute("level")+"_assets.htm");
                dispatcher.forward(request, response);
            }
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
        return "Assets Model Servlet for managing assets in the system";
    }
}
