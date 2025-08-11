package service;

import model.User;
import repository.UserRepository;
import java.util.List;

public class UserService implements IUserService {
    private UserRepository userRepository;
    
    public UserService() {
        this.userRepository = new UserRepository();
    }
    
    @Override
    public User authenticate(String username, String password) {
        if (username == null || password == null || 
            username.trim().isEmpty() || password.trim().isEmpty()) {
            return null;
        }
        return userRepository.authenticate(username.trim(), password);
    }
    
    @Override
    public User getUserById(int id) {
        if (id <= 0) {
            return null;
        }
        return userRepository.getUserById(id);
    }
    
    @Override
    public boolean registerUser(User user) {
        if (user == null || !validateUser(user)) {
            return false;
        }
        
        if (userRepository.isUsernameExists(user.getUsername())) {
            return false;
        }
        
        // Set default role if not specified
        if (user.getRole() == null || user.getRole().trim().isEmpty()) {
            user.setRole("customer");
        }
        
        return userRepository.registerUser(user);
    }
    
    @Override
    public boolean isUsernameExists(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        return userRepository.isUsernameExists(username.trim());
    }
    
    @Override
    public List<User> getAllUsers() {
        return userRepository.getAllUsers();
    }
    
    @Override
    public boolean updateUser(User user) {
        if (user == null || user.getId() <= 0 || !validateUser(user)) {
            return false;
        }
        return userRepository.updateUser(user);
    }
    
    @Override
    public boolean deleteUser(int id) {
        if (id <= 0) {
            return false;
        }
        return userRepository.deleteUser(id);
    }
    
    private boolean validateUser(User user) {
        return user.getUsername() != null && !user.getUsername().trim().isEmpty() &&
               user.getPassword() != null && !user.getPassword().trim().isEmpty() &&
               user.getEmail() != null && !user.getEmail().trim().isEmpty() &&
               user.getFullName() != null && !user.getFullName().trim().isEmpty();
    }
} 