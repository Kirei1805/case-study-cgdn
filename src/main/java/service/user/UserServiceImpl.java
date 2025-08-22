package service.user;

import model.User;
import repository.user.UserRepository;
import repository.user.UserRepositoryImpl;
import org.mindrot.jbcrypt.BCrypt;
import java.util.List;

public class UserServiceImpl implements UserService {
	private final UserRepository userRepository;

	public UserServiceImpl() {
		this.userRepository = new UserRepositoryImpl();
	}

	@Override
	public User login(String username, String password) {
		User user = userRepository.getUserByUsername(username);
		if (user == null) return null;

		String stored = user.getPassword();
		boolean isBcrypt = stored != null && stored.startsWith("$2a$");

		if (isBcrypt) {
			if (BCrypt.checkpw(password, stored)) {
				return user;
			}
			return null;
		} else {
			if (stored != null && stored.equals(password)) {
				String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
				userRepository.updatePassword(user.getId(), hashed);
				user.setPassword(hashed);
				return user;
			}
			return null;
		}
	}

	@Override
	public boolean register(User user) {
		String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashedPassword);
		user.setRole("customer");
		return userRepository.createUser(user);
	}

	@Override
	public User getUserById(int userId) {
		return userRepository.getUserById(userId);
	}

	@Override
	public boolean updateProfile(int userId, String fullName, String email) {
		return userRepository.updateUserInfo(userId, fullName, email);
	}

	@Override
	public boolean updatePassword(int userId, String oldPassword, String newPassword) {
		User user = userRepository.getUserById(userId);
		if (user == null) return false;
		if (!BCrypt.checkpw(oldPassword, user.getPassword())) return false;
		String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt());
		return userRepository.updatePassword(userId, hashed);
	}

	@Override
	public boolean isAdmin(User user) {
		return user != null && "admin".equals(user.getRole());
	}

	@Override
	public List<User> getAllUsers() {
		return userRepository.getAllUsers();
	}

	@Override
	public boolean isUsernameExists(String username) {
		return userRepository.isUsernameExists(username);
	}

	@Override
	public boolean isEmailExists(String email) {
		return userRepository.isEmailExists(email);
	}

	@Override
	public User getById(int id) {
		return userRepository.getUserById(id);
	}

	@Override
	public boolean changePassword(int id, String oldPassword, String newPassword) {
		return updatePassword(id, oldPassword, newPassword);
	}
}

