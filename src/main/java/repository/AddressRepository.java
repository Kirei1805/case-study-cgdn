package repository;

import model.Address;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddressRepository {
	public List<Address> getAddressesByUser(int userId) {
		List<Address> list = new ArrayList<>();
		String sql = "SELECT * FROM addresses WHERE user_id = ? ORDER BY is_default DESC, id DESC";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				list.add(mapAddress(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public Address getDefaultAddress(int userId) {
		String sql = "SELECT * FROM addresses WHERE user_id = ? AND is_default = TRUE LIMIT 1";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) return mapAddress(rs);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean createAddress(Address address) {
		String sql = "INSERT INTO addresses (user_id, recipient_name, phone, address_line, is_default) VALUES (?, ?, ?, ?, ?)";
		try (Connection conn = DBRepository.getConnection();
			 PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, address.getUserId());
			stmt.setString(2, address.getRecipientName());
			stmt.setString(3, address.getPhone());
			stmt.setString(4, address.getAddressLine());
			stmt.setBoolean(5, address.isDefault());
			return stmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean setDefaultAddress(int userId, int addressId) {
		String unset = "UPDATE addresses SET is_default = FALSE WHERE user_id = ?";
		String set = "UPDATE addresses SET is_default = TRUE WHERE id = ? AND user_id = ?";
		try (Connection conn = DBRepository.getConnection()) {
			conn.setAutoCommit(false);
			try (PreparedStatement stmt1 = conn.prepareStatement(unset);
				 PreparedStatement stmt2 = conn.prepareStatement(set)) {
				stmt1.setInt(1, userId);
				stmt1.executeUpdate();
				stmt2.setInt(1, addressId);
				stmt2.setInt(2, userId);
				stmt2.executeUpdate();
				conn.commit();
				return true;
			} catch (SQLException ex) {
				conn.rollback();
				throw ex;
			} finally {
				conn.setAutoCommit(true);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	private Address mapAddress(ResultSet rs) throws SQLException {
		Address a = new Address();
		a.setId(rs.getInt("id"));
		a.setUserId(rs.getInt("user_id"));
		a.setRecipientName(rs.getString("recipient_name"));
		a.setPhone(rs.getString("phone"));
		a.setAddressLine(rs.getString("address_line"));
		a.setDefault(rs.getBoolean("is_default"));
		return a;
	}
}
