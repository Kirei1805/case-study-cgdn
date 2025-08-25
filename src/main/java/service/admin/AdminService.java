package service.admin;

import model.Plant;
import repository.admin.AdminRepository;

import java.util.List;

public class AdminService {
    private AdminRepository adminRepo = new AdminRepository();

    // PLANTS
    public List<Plant> getAllPlants() {
        return adminRepo.getAllPlants();
    }

    public Plant getPlantById(int id) {
        return adminRepo.getPlantById(id);
    }

    public void addPlant(Plant plant) {
        adminRepo.addPlant(plant);
    }

    public void updatePlant(Plant plant) {
        adminRepo.updatePlant(plant);
    }

    public void deletePlant(int id) {
        adminRepo.deletePlant(id);
    }


}
