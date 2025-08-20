package repository;

import model.Category;
import model.Plant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class PlantRepository {
	public List<Plant> getAllPlants() {
		List<Plant> plants = new ArrayList<>();
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

	public List<Plant> getPlantsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice) {
		List<Plant> plants = new ArrayList<>();
		String sql = "SELECT p.*, c.name as category_name FROM plants p " +
					"LEFT JOIN categories c ON p.category_id = c.id " +
					"WHERE p.price BETWEEN ? AND ? AND p.is_active = true";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setBigDecimal(1, minPrice);
			stmt.setBigDecimal(2, maxPrice);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				plants.add(mapPlant(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plants;
	}

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
