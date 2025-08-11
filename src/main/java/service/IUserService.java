package service;

import model.User;
import java.util.List;

public interface IUserService {
    User authenticate(String username, String password);
    User getUserById(int id);
    boolean registerUser(User user);
    boolean isUsernameExists(String username);
    List<User> getAllUsers();
    boolean updateUser(User user);
    boolean deleteUser(int id);
} 