# Plant Shop - Cửa hàng cây cảnh

## Mô tả dự án

Plant Shop là một ứng dụng web bán cây cảnh trực tuyến được phát triển bằng Java Servlet/JSP. Ứng dụng cho phép khách hàng xem danh sách cây cảnh, tìm kiếm, lọc theo danh mục và giá, thêm vào giỏ hàng, đăng ký tài khoản và đặt hàng.

## Tính năng chính

### Cho khách hàng:
- **Xem danh sách cây cảnh**: Hiển thị tất cả sản phẩm với hình ảnh, giá và mô tả
- **Tìm kiếm cây cảnh**: Tìm kiếm theo tên sản phẩm
- **Lọc theo danh mục**: Lọc cây theo loại (Cây văn phòng, Cây thủy sinh, Cây bonsai, Sen đá - Xương rồng)
- **Lọc theo giá**: Tìm cây trong khoảng giá phù hợp
- **Xem chi tiết sản phẩm**: Thông tin đầy đủ về cây cảnh
- **Giỏ hàng**: Thêm, cập nhật số lượng, xóa sản phẩm
- **Đăng ký/Đăng nhập**: Quản lý tài khoản cá nhân
- **Đăng xuất**: Bảo mật tài khoản

### Cho admin:
- Quản lý sản phẩm (thêm, sửa, xóa)
- Quản lý đơn hàng
- Quản lý người dùng
- Thống kê bán hàng

## Công nghệ sử dụng

- **Backend**: Java Servlet, JSP
- **Database**: MySQL
- **Frontend**: HTML5, CSS3, Bootstrap 5, JavaScript
- **Build Tool**: Gradle
- **Server**: Apache Tomcat

## Cấu trúc dự án

```
Plant_shop/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── controller/          # Controllers
│   │   │   │   ├── plant/          # Plant controllers
│   │   │   │   ├── cart/           # Cart controllers
│   │   │   │   └── login/          # Auth controllers
│   │   │   ├── model/              # Entity classes
│   │   │   ├── service/            # Business logic
│   │   │   └── repository/         # Data access
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── view/           # JSP pages
│   │       │   │   ├── common/     # Header, footer
│   │       │   │   ├── plant/      # Plant pages
│   │       │   │   ├── cart/       # Cart pages
│   │       │   │   ├── login/      # Auth pages
│   │       │   │   └── error/      # Error pages
│   │       │   └── web.xml         # Web configuration
│   │       └── index.jsp           # Home page
│   └── test/                       # Test files
├── build.gradle                    # Gradle configuration
├── plant_shop.sql                  # Database schema
└── README.md                       # Project documentation
```

## Cài đặt và chạy

### Yêu cầu hệ thống:
- Java 8 trở lên
- MySQL 5.7 trở lên
- Apache Tomcat 9.0 trở lên
- Gradle (optional, có thể dùng wrapper)

### Bước 1: Cài đặt database
```sql
-- Tạo database
CREATE DATABASE plant_shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Import schema
mysql -u root -p plant_shop < plant_shop.sql
```

### Bước 2: Cấu hình database
Chỉnh sửa thông tin kết nối database trong `src/main/java/repository/DBRepository.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/plant_shop?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

### Bước 3: Build và chạy
```bash
# Sử dụng Gradle wrapper
./gradlew build
./gradlew tomcatRun

# Hoặc build WAR file và deploy lên Tomcat
./gradlew war
# Copy file WAR từ build/libs/ vào webapps/ của Tomcat
```

### Bước 4: Truy cập ứng dụng
Mở trình duyệt và truy cập: `http://localhost:8080/Plant_shop`

## Tài khoản mặc định

### Admin:
- Username: `admin01`
- Password: `admin123`

### Khách hàng:
- Username: `customer01`
- Password: `cust123`
- Username: `customer02`
- Password: `cust456`

## API Endpoints

### Plant Management:
- `GET /plants` - Danh sách cây cảnh
- `GET /plant-detail?id={id}` - Chi tiết cây cảnh
- `GET /plants?category={id}` - Lọc theo danh mục
- `GET /plants?search={term}` - Tìm kiếm theo tên
- `GET /plants?minPrice={price}&maxPrice={price}` - Lọc theo giá

### Cart Management:
- `GET /cart` - Xem giỏ hàng
- `POST /cart` - Thêm/cập nhật/xóa sản phẩm

### Authentication:
- `GET /login` - Trang đăng nhập
- `POST /login` - Xử lý đăng nhập
- `GET /register` - Trang đăng ký
- `POST /register` - Xử lý đăng ký
- `GET /logout` - Đăng xuất

## Database Schema

### Bảng chính:
- `users` - Người dùng (admin/customer)
- `categories` - Danh mục cây cảnh
- `plants` - Sản phẩm cây cảnh
- `cart_items` - Giỏ hàng
- `orders` - Đơn hàng
- `order_items` - Chi tiết đơn hàng
- `reviews` - Đánh giá sản phẩm
- `wishlist` - Danh sách yêu thích
- `addresses` - Địa chỉ giao hàng

## Tính năng bảo mật

- Mã hóa mật khẩu bằng BCrypt
- Session management
- Input validation
- SQL injection prevention
- XSS protection

## Tương lai phát triển

- [ ] Thanh toán online (VNPay, Momo)
- [ ] Quản lý đơn hàng cho admin
- [ ] Hệ thống đánh giá và bình luận
- [ ] Wishlist (danh sách yêu thích)
- [ ] Email notification
- [ ] Responsive design cho mobile
- [ ] API RESTful
- [ ] Unit testing

## Đóng góp

Mọi đóng góp đều được chào đón! Vui lòng tạo issue hoặc pull request.

## License

MIT License
