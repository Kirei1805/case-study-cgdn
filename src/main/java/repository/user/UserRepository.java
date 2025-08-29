package repository.user;

import model.User;
import java.util.List;

public interface UserRepository {
    User getUserByUsername(String username);
    User getUserById(int id);
    boolean createUser(User user);
    boolean updateUserInfo(int userId, String fullName, String email);
    boolean updatePassword(int userId, String hashedPassword);
    List<User> getAllUsers();
    boolean isUsernameExists(String username);
    boolean isEmailExists(String email);
    User getUserByEmail(String email);
}
