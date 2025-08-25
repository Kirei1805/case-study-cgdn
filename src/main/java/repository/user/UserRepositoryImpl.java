package repository.user;

import model.User;
import repository.db.DBRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserRepositoryImpl implements UserRepository {
	
	@Override
	public User getUserByUsername(String username) {
		String sql = "SELECT * FROM users WHERE username = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return mapUser(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean createUser(User user) {
		String sql = "INSERT INTO users (username, password, email, role, full_name) VALUES (?, ?, ?, ?, ?)";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, user.getUsername());
			stmt.setString(2, user.getPassword());
			stmt.setString(3, user.getEmail());
			stmt.setString(4, user.getRole() != null ? user.getRole() : "customer");
			stmt.setString(5, user.getFullName());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public User getUserById(int userId) {
		String sql = "SELECT * FROM users WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return mapUser(rs);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean updateUserInfo(int userId, String fullName, String email) {
		String sql = "UPDATE users SET full_name = ?, email = ? WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, fullName);
			stmt.setString(2, email);
			stmt.setInt(3, userId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean updatePassword(int userId, String hashedPassword) {
		String sql = "UPDATE users SET password = ? WHERE id = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, hashedPassword);
			stmt.setInt(2, userId);
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<User> getAllUsers() {
		List<User> users = new ArrayList<>();
		String sql = "SELECT * FROM users ORDER BY created_at DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				users.add(mapUser(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	@Override
	public boolean isUsernameExists(String username) {
		String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, username);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean isEmailExists(String email) {
		String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, email);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private User mapUser(ResultSet rs) throws SQLException {
		User user = new User();
		user.setId(rs.getInt("id"));
		user.setUsername(rs.getString("username"));
		user.setPassword(rs.getString("password"));
		user.setEmail(rs.getString("email"));
		user.setRole(rs.getString("role"));
		user.setFullName(rs.getString("full_name"));
		Timestamp ts = rs.getTimestamp("created_at");
		if (ts != null) {
			user.setCreatedAt(ts.toLocalDateTime());
		} else {
			user.setCreatedAt(null);
		}
		return user;
	}
}

