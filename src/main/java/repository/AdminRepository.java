package repository;

import model.Plant;
import model.Order;
import repository.db.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminRepository {

    // ===== PLANTS =====
    public List<Plant> getAllPlants() {
        List<Plant> plants = new ArrayList<>();
        String sql = "SELECT * FROM plants";

        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                plants.add(mapResultSetToPlant(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return plants;
    }

    public Plant getPlantById(int id) {
        String sql = "SELECT * FROM plants WHERE id = ?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToPlant(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addPlant(Plant plant) {
        String sql = "INSERT INTO plants (name, price, image_url, description, stock, rating_avg, category_id, is_active) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, plant.getName());
            ps.setBigDecimal(2, plant.getPrice());
            ps.setString(3, plant.getImageUrl());
            ps.setString(4, plant.getDescription());
            ps.setInt(5, plant.getStock());
            ps.setFloat(6, plant.getRatingAvg());
            ps.setInt(7, plant.getCategoryId());
            ps.setBoolean(8, plant.isActive());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updatePlant(Plant plant) {
        String sql = "UPDATE plants SET name=?, price=?, image_url=?, description=?, stock=?, rating_avg=?, category_id=?, is_active=? WHERE id=?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, plant.getName());
            ps.setBigDecimal(2, plant.getPrice());
            ps.setString(3, plant.getImageUrl());
            ps.setString(4, plant.getDescription());
            ps.setInt(5, plant.getStock());
            ps.setFloat(6, plant.getRatingAvg());
            ps.setInt(7, plant.getCategoryId());
            ps.setBoolean(8, plant.isActive());
            ps.setInt(9, plant.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deletePlant(int id) {
        String sql = "DELETE FROM plants WHERE id=?";
        try (Connection conn = DBRepository.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Plant mapResultSetToPlant(ResultSet rs) throws SQLException {
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
        return plant;
    }



}
