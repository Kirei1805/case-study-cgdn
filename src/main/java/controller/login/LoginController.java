package controller.login;

import model.User;
import service.user.UserService;
import service.user.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	private UserService userService;

	@Override
	public void init() throws ServletException {
		userService = new UserServiceImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user != null) {
			if (userService.isAdmin(user)) {
				response.sendRedirect(request.getContextPath() + "/admin");
			} else {
				response.sendRedirect(request.getContextPath() + "/");
			}
			return;
		}
		request.getRequestDispatcher("/WEB-INF/view/login/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String redirect = request.getParameter("redirect");

		if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
			request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin");
			request.getRequestDispatcher("/WEB-INF/view/login/login.jsp").forward(request, response);
			return;
		}

		User user = userService.login(username.trim(), password);
		if (user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", user);

			if (userService.isAdmin(user)) {
				response.sendRedirect(request.getContextPath() + "/admin");
			} else {
				if (redirect != null && !redirect.trim().isEmpty()) {
					response.sendRedirect(redirect);
				} else {
					response.sendRedirect(request.getContextPath() + "/");
				}
			}
		} else {
			request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
			request.getRequestDispatcher("/WEB-INF/view/login/login.jsp").forward(request, response);
		}
	}
}
