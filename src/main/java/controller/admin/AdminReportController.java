package controller.admin;

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

@WebServlet("/admin/reports")
public class AdminReportController extends HttpServlet {
	private UserService userService;

	@Override
	public void init() throws ServletException {
		userService = new UserServiceImpl();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		if (user == null || !userService.isAdmin(user)) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		request.setAttribute("adminUser", user);
		request.getRequestDispatcher("/WEB-INF/view/admin/reports.jsp").forward(request, response);
	}
}
