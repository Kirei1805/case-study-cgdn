package repository.category;

import model.Category;
import repository.db.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryRepositoryImpl implements CategoryRepository {
	
	@Override
	public List<Category> getAllCategories() {
		List<Category> categories = new ArrayList<>();
		String sql = "SELECT * FROM categories ORDER BY name";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql);
			 ResultSet rs = stmt.executeQuery()) {
			while (rs.next()) {
				Category category = new Category();
				category.setId(rs.getInt("id"));
				category.setName(rs.getString("name"));
				categories.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return categories;
	}

	@Override
	public Category getCategoryById(int id) {
		String sql = "SELECT * FROM categories WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, id);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				Category category = new Category();
				category.setId(rs.getInt("id"));
				category.setName(rs.getString("name"));
				return category;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean createCategory(Category category) {
		String sql = "INSERT INTO categories (name) VALUES (?)";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, category.getName());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updateCategory(Category category) {
		String sql = "UPDATE categories SET name = ? WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, category.getName());
			stmt.setInt(2, category.getId());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deleteCategory(int id) {
		String sql = "DELETE FROM categories WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, id);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}

