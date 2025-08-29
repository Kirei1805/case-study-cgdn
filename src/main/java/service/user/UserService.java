package service.user;

import model.User;
import java.util.List;

public interface UserService {
    User login(String username, String password);
    boolean register(User user);
    User getUserById(int userId);
    boolean updateProfile(int userId, String fullName, String email);
    boolean updatePassword(int userId, String oldPassword, String newPassword);
    boolean isAdmin(User user);
    List<User> getAllUsers();
    boolean isUsernameExists(String username);
    boolean isEmailExists(String email);
    User getUserByEmail(String email);

    User getById(int id);

    boolean changePassword(int id, String oldPassword, String newPassword);
}
