package controller.admin;

import model.User;
import model.Order;
import service.user.UserService;
import service.user.UserServiceImpl;
import service.order.OrderService;
import service.order.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {
	private UserService userService;
	private OrderService orderService;

	@Override
	public void init() throws ServletException {
		userService = new UserServiceImpl();
		orderService = new OrderServiceImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if (user == null || !userService.isAdmin(user)) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		try {
			// Test 1: Check if services are initialized
			System.out.println("AdminDashboard: Services initialized successfully");
			
			// Test 2: Try to get orders
			System.out.println("AdminDashboard: Getting orders...");
			List<Order> recentOrders = orderService.getAllOrders();
			System.out.println("AdminDashboard: Got " + recentOrders.size() + " orders");
			
			// Test 3: Try to get users
			System.out.println("AdminDashboard: Getting users...");
			List<User> allUsers = userService.getAllUsers();
			System.out.println("AdminDashboard: Got " + allUsers.size() + " users");
			
			// Test 4: Calculate statistics
			long totalOrders = recentOrders.size();
			long totalUsers = allUsers.size();
			long pendingOrders = recentOrders.stream().filter(o -> "pending".equals(o.getStatus())).count();
			
			System.out.println("AdminDashboard: Statistics calculated - Orders: " + totalOrders + ", Users: " + totalUsers + ", Pending: " + pendingOrders);
			
			// Test 5: Set attributes
			request.setAttribute("recentOrders", recentOrders);
			request.setAttribute("totalOrders", totalOrders);
			request.setAttribute("totalUsers", totalUsers);
			request.setAttribute("pendingOrders", pendingOrders);
			
			System.out.println("AdminDashboard: Attributes set successfully");
			
			// Test 6: Forward to JSP
			System.out.println("AdminDashboard: Forwarding to dashboard.jsp");
			request.getRequestDispatcher("/WEB-INF/view/admin/dashboard.jsp").forward(request, response);
			
		} catch (Exception e) {
			System.err.println("AdminDashboard Error: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("errorMessage", e.getMessage());
			request.setAttribute("errorStackTrace", e.getStackTrace());
			request.getRequestDispatcher("/WEB-INF/view/error/500.jsp").forward(request, response);
		}
	}
}
