package controller.user;

import model.User;
import model.Order;
import model.OrderItem;
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
import util.PaginationUtil;

@WebServlet(urlPatterns = {"/orders", "/order-success", "/order-detail"})
public class OrderController extends HttpServlet {
	private OrderService orderService;

	@Override
	public void init() throws ServletException {
		orderService = new OrderServiceImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login?redirect=" + request.getRequestURI());
			return;
		}

		String servletPath = request.getServletPath();
		if ("/order-success".equals(servletPath)) {
			String id = request.getParameter("id");
			request.setAttribute("orderId", id);
			request.getRequestDispatcher("/WEB-INF/view/cart/order-success.jsp").forward(request, response);
			return;
		}

		if ("/order-detail".equals(servletPath)) {
			String idStr = request.getParameter("id");
			try {
				int id = Integer.parseInt(idStr);
				Order order = orderService.getOrderById(id);
				if (order == null || order.getUserId() != user.getId()) {
					response.sendError(HttpServletResponse.SC_FORBIDDEN);
					return;
				}
				List<OrderItem> items = orderService.getOrderItems(id);
				request.setAttribute("order", order);
				request.setAttribute("items", items);
				request.getRequestDispatcher("/WEB-INF/view/user/order-detail.jsp").forward(request, response);
				return;
			} catch (NumberFormatException e) {
				response.sendRedirect(request.getContextPath() + "/orders");
				return;
			}
		}

		// Get pagination parameters
		String pageParam = request.getParameter("page");
		String sizeParam = request.getParameter("size");
		
		int page = 1;
		int size = 5; // Default page size for user orders
		
		try {
			if (pageParam != null && !pageParam.trim().isEmpty()) {
				page = Integer.parseInt(pageParam);
			}
			if (sizeParam != null && !sizeParam.trim().isEmpty()) {
				size = Integer.parseInt(sizeParam);
				// Limit page size to reasonable values
				size = Math.min(Math.max(size, 1), 50);
			}
		} catch (NumberFormatException e) {
			// Use defaults if invalid numbers
		}
		
		// Get all user orders
		List<Order> allOrders = orderService.getOrdersByUser(user.getId());
		
		// Create pagination
		PaginationUtil<Order> pagination = new PaginationUtil<>(allOrders, page, size);
		List<Order> orders = pagination.getPageItems();
		
		// Build other params for pagination links
		StringBuilder otherParams = new StringBuilder();
		if (sizeParam != null && !sizeParam.trim().isEmpty()) {
			otherParams.append("size=").append(size);
		}
		
		request.setAttribute("orders", orders);
		request.setAttribute("pagination", pagination);
		request.setAttribute("pageUrl", request.getContextPath() + "/orders?");
		request.setAttribute("otherParams", otherParams.toString());
		request.getRequestDispatcher("/WEB-INF/view/user/orders.jsp").forward(request, response);
	}
}
