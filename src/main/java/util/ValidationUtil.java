package util;

import java.util.regex.Pattern;

public class ValidationUtil {
    
    // Regex patterns
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@" +
        "(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$"
    );
    
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,20}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[a-zA-Z])(?=.*\\d)[a-zA-Z\\d@$!%*?&]{6,}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^(0[3|5|7|8|9])+([0-9]{8})$");
    
    /**
     * Validate email format
     */
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }
    
    /**
     * Validate username format (3-20 characters, alphanumeric and underscore only)
     */
    public static boolean isValidUsername(String username) {
        return username != null && USERNAME_PATTERN.matcher(username).matches();
    }
    
    /**
     * Validate password strength (at least 6 characters, contains letter and digit)
     */
    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }
    
    /**
     * Validate Vietnamese phone number
     */
    public static boolean isValidPhone(String phone) {
        return phone != null && PHONE_PATTERN.matcher(phone).matches();
    }
    
    /**
     * Validate full name (2-50 characters, letters, spaces, Vietnamese characters)
     */
    public static boolean isValidFullName(String fullName) {
        if (fullName == null || fullName.trim().isEmpty()) return false;
        String trimmed = fullName.trim();
        return trimmed.length() >= 2 && trimmed.length() <= 50 && 
               trimmed.matches("^[a-zA-ZÀ-ỹ\\s]+$");
    }
    
    /**
     * Validate string is not null or empty
     */
    public static boolean isNotEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }
    
    /**
     * Validate string length
     */
    public static boolean isValidLength(String str, int min, int max) {
        if (str == null) return false;
        int length = str.trim().length();
        return length >= min && length <= max;
    }
    
    /**
     * Validate positive number
     */
    public static boolean isPositiveNumber(String str) {
        try {
            double num = Double.parseDouble(str);
            return num > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
    
    /**
     * Validate positive integer
     */
    public static boolean isPositiveInteger(String str) {
        try {
            int num = Integer.parseInt(str);
            return num > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}

