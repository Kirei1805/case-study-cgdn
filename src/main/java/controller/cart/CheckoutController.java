package controller.cart;

import model.Address;
import model.User;
import service.address.AddressService;
import service.address.AddressServiceImpl;
import service.order.OrderService;
import service.order.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutController extends HttpServlet {
	private AddressService addressService;
	private OrderService orderService;

	@Override
	public void init() throws ServletException {
		addressService = new AddressServiceImpl();
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
		
		// Get cart items and total for display
		service.cart.CartService cartService = new service.cart.CartServiceImpl();
		List<model.CartItem> cartItems = cartService.getCartItems(user.getId());
		double total = cartService.getCartTotal(user.getId());
		
		// Redirect to cart if empty
		if (cartItems.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/cart");
			return;
		}
		
		List<Address> addresses = addressService.getAddressesByUser(user.getId());
		if (addresses == null) addresses = new ArrayList<>();
		Address defaultAddress = addressService.getDefaultAddress(user.getId());
		Integer defaultAddressId = defaultAddress != null ? defaultAddress.getId() : null;
		
		request.setAttribute("cartItems", cartItems);
		request.setAttribute("total", total);
		request.setAttribute("addresses", addresses);
		request.setAttribute("defaultAddressId", defaultAddressId);
		request.getRequestDispatcher("/WEB-INF/view/cart/checkout.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login?redirect=" + request.getRequestURI());
			return;
		}

		String action = request.getParameter("action");
		if ("createAddress".equals(action)) {
			String recipientName = request.getParameter("recipientName");
			String phone = request.getParameter("phone");
			String addressLine = request.getParameter("addressLine");
			String setDefault = request.getParameter("setDefault");

			if (recipientName == null || phone == null || addressLine == null ||
				recipientName.trim().isEmpty() || phone.trim().isEmpty() || addressLine.trim().isEmpty()) {
				request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin địa chỉ");
				doGet(request, response);
				return;
			}
			Address a = new Address();
			a.setUserId(user.getId());
			a.setRecipientName(recipientName.trim());
			a.setPhone(phone.trim());
			a.setAddressLine(addressLine.trim());
			a.setDefault("on".equalsIgnoreCase(setDefault));
			boolean created = addressService.createAddress(a);
			if (created && a.isDefault()) {
				// Note: We would need address ID to set as default, for now skip this part
				// addressService.setDefaultAddress(user.getId(), newId);
			}
			response.sendRedirect(request.getContextPath() + "/checkout");
			return;
		}

		String addressIdStr = request.getParameter("addressId");
		if (addressIdStr == null || addressIdStr.trim().isEmpty()) {
			request.setAttribute("error", "Vui lòng chọn địa chỉ giao hàng");
			doGet(request, response);
			return;
		}
		int addressId = Integer.parseInt(addressIdStr);
		
		// Use the helper method from OrderServiceImpl to checkout from cart
		int orderId = 0;
		if (orderService instanceof OrderServiceImpl) {
			orderId = ((OrderServiceImpl) orderService).checkoutFromCartAndGetOrderId(user.getId(), addressId);
		}
		
		if (orderId <= 0) {
			request.setAttribute("error", "Giỏ hàng trống hoặc có lỗi khi tạo đơn hàng");
			doGet(request, response);
			return;
		}
		response.sendRedirect(request.getContextPath() + "/order-success?id=" + orderId);
	}
}
