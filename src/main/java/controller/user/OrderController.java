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

		List<Order> orders = orderService.getOrdersByUser(user.getId());
		request.setAttribute("orders", orders);
		request.getRequestDispatcher("/WEB-INF/view/user/orders.jsp").forward(request, response);
	}
}
