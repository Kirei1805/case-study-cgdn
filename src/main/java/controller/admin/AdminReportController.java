package controller.admin;

import model.User;
import service.user.UserService;
import service.user.UserServiceImpl;
import service.order.OrderService;
import service.order.OrderServiceImpl;
import service.plant.PlantService;
import service.plant.PlantServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.Order;
import model.Plant;

@WebServlet("/admin/reports")
public class AdminReportController extends HttpServlet {
	private UserService userService;
	private OrderService orderService;
	private PlantService plantService;

	@Override
	public void init() throws ServletException {
		userService = new UserServiceImpl();
		orderService = new OrderServiceImpl();
		plantService = new PlantServiceImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if (user == null || !userService.isAdmin(user)) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		// Generate statistics
		generateReportData(request);

		request.setAttribute("adminUser", user);
		request.getRequestDispatcher("/WEB-INF/view/admin/reports.jsp").forward(request, response);
	}
	
	private void generateReportData(HttpServletRequest request) {
		try {
			List<Order> orders = orderService.getAllOrders();
			List<Plant> plants = plantService.getAllPlants();
			List<User> users = userService.getAllUsers();
			
			// Calculate total revenue
			BigDecimal totalRevenue = orders.stream()
				.filter(o -> "shipped".equals(o.getStatus()) || "delivered".equals(o.getStatus()))
				.map(o -> o.getTotalAmount())
				.reduce(BigDecimal.ZERO, BigDecimal::add);
			
			// Count successful orders
			long successfulOrders = orders.stream()
				.filter(o -> "shipped".equals(o.getStatus()) || "delivered".equals(o.getStatus()))
				.count();
			
			// Count new customers (customers only, not admin)
			long newCustomers = users.stream()
				.filter(u -> "customer".equals(u.getRole()))
				.count();
			
			// Find best-selling products (mock data for now)
			// TODO: Implement real bestseller logic with OrderItems
			
			request.setAttribute("totalRevenue", totalRevenue);
			request.setAttribute("successfulOrders", successfulOrders);
			request.setAttribute("newCustomers", newCustomers);
			request.setAttribute("totalProducts", plants.size());
			
		} catch (Exception e) {
			e.printStackTrace();
			// Set default values on error
			request.setAttribute("totalRevenue", BigDecimal.ZERO);
			request.setAttribute("successfulOrders", 0L);
			request.setAttribute("newCustomers", 0L);
			request.setAttribute("totalProducts", 0);
		}
	}
}
