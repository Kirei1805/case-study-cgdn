package controller.plant;

import service.PlantService;
import model.Plant;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/plant-detail")
public class PlantDetailController extends HttpServlet {
    private PlantService plantService;

    @Override
    public void init() throws ServletException {
        plantService = new PlantService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String plantId = request.getParameter("id");
        
        if (plantId != null && !plantId.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(plantId);
                Plant plant = plantService.getPlantById(id);
                
                if (plant != null) {
                    request.setAttribute("plant", plant);
                    request.getRequestDispatcher("/WEB-INF/view/plant/plant-detail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/plants?error=notfound");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/plants?error=invalid");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/plants");
        }
    }
}
