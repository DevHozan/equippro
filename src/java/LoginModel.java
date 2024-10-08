import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * Servlet implementation class LoginModel
 */
public class LoginModel extends HttpServlet {

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
           
            
                 // Get parameters from the request
        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim(); // Assuming you are sending password too
        
        if(!email.isEmpty() && !password.isEmpty()){
            
        

                    // Example query to check if the user exists
                 String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            List<Map<String, Object>> users = jdbcTemplate.queryForList(sql, new Object[]{email, password});

            // Check if a user was found
            if (!users.isEmpty()) {
                Map<String, Object> user = users.get(0); // Get the first user
                String level = (String) user.get("level"); // Assuming "level" is a column in your users table

                 session.setAttribute("level", level);
                    session.setAttribute("id", user.get("id"));
                if ("admin".equals(level)) {
                   
                    response.sendRedirect("Dashboard");
                } else {
                    response.sendRedirect(level + "_dashboard.htm");
// Redirect for non-admin users
                }
            } else{
               // Obtain the session from the request object
                    

                    // Set the message attribute in the session
                    String message = "Invalid credentials";
                    session.setAttribute("message", message);

          
             response.sendRedirect("login.htm");
                
            }
            
        }else{
            String message = "All forms are required";
            session.setAttribute("message", message);
            response.sendRedirect("login.htm");
        }
        
            // Process the request here
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
        return "Login Model Servlet";
    }
}
