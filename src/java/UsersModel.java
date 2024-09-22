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
 * User Model Servlet to manage user data.
 *
 * @author Hozana
 */
public class UsersModel extends HttpServlet {
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
            String userId = request.getParameter("user_id");

            // Handling Activate and Deactivate actions
            if ("Activate".equals(action) || "Deactivate".equals(action)) {
                String status = "Activate".equals(action) ? "active" : "inactive";
                String sqlUpdate = "UPDATE users SET status = ? WHERE id = ?";
                jdbcTemplate.update(sqlUpdate, status, userId);

//                RequestDispatcher dispatcher = request.getRequestDispatcher("a_users.jsp");
//                dispatcher.forward(request, response);
            }
            
            if ("Add".equals(action)) {
                String names = request.getParameter("names");
                String email = request.getParameter("email");
                String tel = request.getParameter("tel");
                String password = request.getParameter("password");
                String status = "active"; // Default status when adding a new user
                String level = request.getParameter("level");

                // Corrected SQL statement without duplicate columns
                String sqlInsert = "INSERT INTO users (names, email, tel, password, status, level) VALUES(?, ?, ?, ?, ?, ?)";

                // Execute the insertion query
                jdbcTemplate.update(sqlInsert, names, email, tel, password, status, level);

                // Optional: Set a success message in the session or redirect accordingly
                session.setAttribute("message", "User added successfully.");
            }

            // Querying the users list
            String sql = "SELECT * FROM users ORDER BY date DESC";
            List<Map<String, Object>> usersList = jdbcTemplate.queryForList(sql);

            // If users found, forward to users page, otherwise show no users page
            if (usersList != null && !usersList.isEmpty()) {
                request.setAttribute("users", usersList);
                RequestDispatcher dispatcher = request.getRequestDispatcher((String)session.getAttribute("level")+"_users.htm");
                dispatcher.forward(request, response);
            } else {
                out.println("<p>No users found in the system.</p>");
                RequestDispatcher dispatcher = request.getRequestDispatcher((String)session.getAttribute("level")+"_users.htm");
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
        return "User Model Servlet for managing users in the system";
    }
}
