package service;

import model.User;
import repository.UserRepository;
import org.mindrot.jbcrypt.BCrypt;

public class UserService {
	private final UserRepository userRepository;

	public UserService() {
		this.userRepository = new UserRepository();
	}

    public User login(String username, String password) {
        User user = userRepository.getUserByUsername(username);
        if (user != null && password.equals(user.getPassword())) {
            return user;
        }
        return null;
    }


    public boolean register(User user) {
		String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
		user.setPassword(hashedPassword);
		user.setRole("customer");
		return userRepository.createUser(user);
	}

	public boolean isUsernameExists(String username) {
		User user = userRepository.getUserByUsername(username);
		return user != null;
	}
}
