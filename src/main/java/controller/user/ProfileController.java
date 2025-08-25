package controller.user;

import model.User;
import service.user.UserService;
import service.user.UserServiceImpl;
import service.address.AddressService;
import service.address.AddressServiceImpl;
import model.Address;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {
	private UserService userService;
	private AddressService addressService;

	@Override
	public void init() throws ServletException {
		userService = new UserServiceImpl();
		addressService = new AddressServiceImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login?redirect=" + request.getRequestURI());
			return;
		}
		User fresh = userService.getById(user.getId());
		List<Address> addresses = addressService.getAddressesByUser(user.getId());
		request.setAttribute("userProfile", fresh);
		request.setAttribute("addresses", addresses);
		request.getRequestDispatcher("/WEB-INF/view/user/profile.jsp").forward(request, response);
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
		if ("updateProfile".equals(action)) {
			String fullName = request.getParameter("fullName");
			String email = request.getParameter("email");
			if (fullName == null || email == null || fullName.trim().isEmpty() || email.trim().isEmpty()) {
				request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
				doGet(request, response);
				return;
			}
			boolean ok = userService.updateProfile(user.getId(), fullName.trim(), email.trim());
			if (ok) {
				request.setAttribute("success", "Cập nhật hồ sơ thành công");
			} else {
				request.setAttribute("error", "Có lỗi xảy ra, vui lòng thử lại");
			}
			doGet(request, response);
			return;
		} else if ("changePassword".equals(action)) {
			String oldPassword = request.getParameter("oldPassword");
			String newPassword = request.getParameter("newPassword");
			String confirmPassword = request.getParameter("confirmPassword");
			if (oldPassword == null || newPassword == null || confirmPassword == null ||
				oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
				request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
				doGet(request, response);
				return;
			}
			if (!newPassword.equals(confirmPassword)) {
				request.setAttribute("error", "Mật khẩu xác nhận không khớp");
				doGet(request, response);
				return;
			}
			boolean ok = userService.changePassword(user.getId(), oldPassword, newPassword);
			if (ok) {
				request.setAttribute("success", "Đổi mật khẩu thành công");
			} else {
				request.setAttribute("error", "Mật khẩu cũ không đúng hoặc có lỗi");
			}
			doGet(request, response);
			return;
		}
		response.sendRedirect(request.getContextPath() + "/profile");
	}
}

