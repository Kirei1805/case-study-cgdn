package repository.plant;

import model.Category;
import model.Plant;
import repository.db.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class PlantRepositoryImpl implements PlantRepository {
	
	@Override
	public List<Plant> getAllPlants() {
		List<Plant> plants = new ArrayList<>();
		// For public use - only active plants
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE p.is_active = true ORDER BY p.id DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql);
			 ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Plant plant = mapPlant(rs);
				plants.add(plant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plants;
	}

	@Override
	public List<Plant> getAllPlantsForAdmin() {
		List<Plant> plants = new ArrayList<>();
		// For admin - get all plants regardless of status
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"ORDER BY p.id DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql);
			 ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Plant plant = mapPlant(rs);
				plants.add(plant);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plants;
	}

	@Override
	public List<Plant> getPlantsByCategory(int categoryId) {
		List<Plant> plants = new ArrayList<>();
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE p.category_id = ? AND p.is_active = true";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, categoryId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				plants.add(mapPlant(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plants;
	}

	@Override
	public List<Plant> searchPlantsByName(String searchTerm) {
		List<Plant> plants = new ArrayList<>();
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE p.name LIKE ? AND p.is_active = true";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, "%" + searchTerm + "%");
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				plants.add(mapPlant(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plants;
	}

	@Override
	public Plant getPlantById(int id) {
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE p.id = ? AND p.is_active = true";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return mapPlant(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Plant> getRelatedPlants(int plantId, int categoryId, int limit) {
		List<Plant> plants = new ArrayList<>();
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE p.is_active = true AND p.category_id = ? AND p.id <> ? " +
					"ORDER BY p.rating_avg DESC, p.id DESC LIMIT ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, categoryId);
			stmt.setInt(2, plantId);
			stmt.setInt(3, limit);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				plants.add(mapPlant(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plants;
	}

	@Override
	public boolean updateStock(int plantId, int quantity) {
		String sql = "UPDATE plants SET stock = stock - ? WHERE id = ? AND stock >= ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, quantity);
			stmt.setInt(2, plantId);
			stmt.setInt(3, quantity);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean createPlant(Plant plant) {
		String sql = "INSERT INTO plants (name, price, image_url, description, stock, category_id, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, plant.getName());
			stmt.setBigDecimal(2, plant.getPrice());
			stmt.setString(3, plant.getImageUrl());
			stmt.setString(4, plant.getDescription());
			stmt.setInt(5, plant.getStock());
			stmt.setInt(6, plant.getCategoryId());
			stmt.setBoolean(7, plant.isActive());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updatePlant(Plant plant) {
		String sql = "UPDATE plants SET name = ?, price = ?, image_url = ?, description = ?, stock = ?, category_id = ?, is_active = ? WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, plant.getName());
			stmt.setBigDecimal(2, plant.getPrice());
			stmt.setString(3, plant.getImageUrl());
			stmt.setString(4, plant.getDescription());
			stmt.setInt(5, plant.getStock());
			stmt.setInt(6, plant.getCategoryId());
			stmt.setBoolean(7, plant.isActive());
			stmt.setInt(8, plant.getId());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

    @Override
    public boolean deletePlant(int plantId) {
        String sql = "DELETE FROM plants WHERE id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, plantId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    @Override
	public List<Plant> getPlantsByStatus(boolean isActive) {
		List<Plant> plants = new ArrayList<>();
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE p.is_active = ? ORDER BY p.id DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setBoolean(1, isActive);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				plants.add(mapPlant(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plants;
	}

	@Override
	public List<Plant> getPlantsByPriceRange(BigDecimal min, BigDecimal max) {
		List<Plant> plants = new ArrayList<>();
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE p.is_active = true AND p.price >= ? AND p.price <= ? " +
					"ORDER BY p.price ASC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setBigDecimal(1, min);
			stmt.setBigDecimal(2, max);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				plants.add(mapPlant(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plants;
	}

	private Plant mapPlant(ResultSet rs) throws SQLException {
		Plant plant = new Plant();
		plant.setId(rs.getInt("id"));
		plant.setName(rs.getString("name"));
		plant.setPrice(rs.getBigDecimal("price"));
		plant.setImageUrl(rs.getString("image_url"));
		plant.setDescription(rs.getString("description"));
		plant.setStock(rs.getInt("stock"));
		plant.setRatingAvg(rs.getFloat("rating_avg"));
		plant.setCategoryId(rs.getInt("category_id"));
		plant.setActive(rs.getBoolean("is_active"));
		Category category = new Category();
		category.setId(rs.getInt("category_id"));
		category.setName(rs.getString("category_name"));
		plant.setCategory(category);
		return plant;
	}
}

