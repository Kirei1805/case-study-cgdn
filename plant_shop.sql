CREATE DATABASE IF NOT EXISTS plant_shop;
USE plant_shop;

-- 1. Bảng người dùng (admin và khách hàng)
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       password VARCHAR(100) NOT NULL,
                       email VARCHAR(100) UNIQUE,
                       role ENUM('customer', 'admin') DEFAULT 'customer',
                       full_name VARCHAR(100),
                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Bảng địa chỉ giao hàng
CREATE TABLE addresses (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           user_id INT,
                           recipient_name VARCHAR(100),
                           phone VARCHAR(20),
                           address_line TEXT,
                           is_default BOOLEAN DEFAULT FALSE,
                           FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 3. Bảng loại cây
CREATE TABLE categories (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            name VARCHAR(100) NOT NULL
);

-- 4. Bảng sản phẩm cây cảnh
CREATE TABLE plants (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(255) NOT NULL,
                        price DECIMAL(10,2) NOT NULL,
                        image_url TEXT,
                        description TEXT,
                        stock INT DEFAULT 0,
                        rating_avg FLOAT DEFAULT 0,
                        category_id INT,
                        is_active BOOLEAN DEFAULT TRUE,
                        FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 5. Bảng giỏ hàng
CREATE TABLE cart_items (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            user_id INT,
                            plant_id INT,
                            quantity INT DEFAULT 1,
                            FOREIGN KEY (user_id) REFERENCES users(id),
                            FOREIGN KEY (plant_id) REFERENCES plants(id),
                            UNIQUE(user_id, plant_id)
);

-- 6. Bảng đơn hàng
CREATE TABLE orders (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id INT,
                        address_id INT,
                        total_amount DECIMAL(10,2),
                        status ENUM('pending', 'processing', 'shipped', 'cancelled') DEFAULT 'pending',
                        order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(id),
                        FOREIGN KEY (address_id) REFERENCES addresses(id)
);

-- 7. Bảng chi tiết đơn hàng
CREATE TABLE order_items (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             order_id INT,
                             plant_id INT,
                             quantity INT,
                             unit_price DECIMAL(10,2),
                             FOREIGN KEY (order_id) REFERENCES orders(id),
                             FOREIGN KEY (plant_id) REFERENCES plants(id)
);

-- 8. Bảng đánh giá sản phẩm
CREATE TABLE reviews (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         user_id INT,
                         plant_id INT,
                         rating INT CHECK (rating BETWEEN 1 AND 5),
                         comment TEXT,
                         review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (user_id) REFERENCES users(id),
                         FOREIGN KEY (plant_id) REFERENCES plants(id)
);

-- 9. Bảng wishlist (sản phẩm yêu thích)
CREATE TABLE wishlist (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          user_id INT,
                          plant_id INT,
                          created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (user_id) REFERENCES users(id),
                          FOREIGN KEY (plant_id) REFERENCES plants(id),
                          UNIQUE(user_id, plant_id)
);





INSERT INTO users (username, password, email, role, full_name)
VALUES
    ('admin01', 'admin123', 'admin@example.com', 'admin', 'Nguyễn Văn Admin'),
    ('customer01', 'cust123', 'cust1@example.com', 'customer', 'Trần Thị Khách'),
    ('customer02', 'cust456', 'cust2@example.com', 'customer', 'Lê Văn Mua');


INSERT INTO addresses (user_id, recipient_name, phone, address_line, is_default)
VALUES
    (2, 'Trần Thị Khách', '0909123456', '123 Lê Lợi, Quận 1, TP.HCM', TRUE),
    (3, 'Lê Văn Mua', '0911123456', '456 Nguyễn Huệ, Quận 1, TP.HCM', TRUE);

INSERT INTO categories (name)
VALUES
    ('Cây văn phòng'),
    ('Cây thủy sinh'),
    ('Cây bonsai'),
    ('Sen đá - Xương rồng');

INSERT INTO plants (name, price, image_url, description, stock, rating_avg, category_id)
VALUES
-- Cây văn phòng (category_id = 1)
('Cây Kim Tiền', 150000, 'https://th.bing.com/th/id/OIP.QEWKkjasNqyNqnKEusp6gQHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3', 'Cây phong thủy hút tài lộc, dễ chăm sóc.', 20, 4.5, 1),
('Cây Lưỡi Hổ', 100000, 'https://tse2.mm.bing.net/th/id/OIP.-D5qNMJr4DFBwHbQmCUpkAHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', 'Thanh lọc không khí, tốt cho giấc ngủ.', 30, 4.3, 1),
('Cây Trầu Bà', 90000, 'https://tse4.mm.bing.net/th/id/OIP.F81RVsbulFsAgpH8ssDwXQHaJ4?rs=1&pid=ImgDetMain&o=7&rm=3', 'Dễ trồng, sinh trưởng nhanh, lọc khí tốt.', 25, 4.1, 1),
('Cây Ngọc Ngân', 120000, 'https://tse1.mm.bing.net/th/id/OIP.meoZGjpEtNltBVdRqxNcqgHaF6?rs=1&pid=ImgDetMain&o=7&rm=3', 'Cây cảnh để bàn có màu lá đẹp, sang trọng.', 18, 4.4, 1),

-- Cây thủy sinh (category_id = 2)
('Cây Bạc Hà Thủy Sinh', 75000, 'https://tse1.mm.bing.net/th/id/OIP.KLXobFcahAOlyd86rKvFxAHaGg?rs=1&pid=ImgDetMain&o=7&rm=3', 'Cây thủy sinh mát mắt, dễ trồng trong nước.', 40, 4.2, 2),
('Cây Thủy Sinh Cẩm Thạch', 85000, 'https://caycanhxanh.vn/wp-content/uploads/2023/03/ngoc-ngan-thuy-sinh.jpg', 'Lá cẩm thạch lạ mắt, trồng bình thủy tinh.', 35, 4.0, 2),
('Cây Phát Lộc', 110000, 'https://th.bing.com/th/id/OIP._zQnaUKDL1BNEiu4n7dgigHaHa?o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3', 'Mang lại may mắn, tài lộc, sống tốt trong nước.', 28, 4.6, 2),

-- Cây bonsai (category_id = 3)
('Cây Bonsai Tùng La Hán', 350000, 'https://tse1.mm.bing.net/th/id/OIP.DWp8e9XGgWcyCzWOv2j9PQHaJ4?rs=1&pid=ImgDetMain&o=7&rm=3', 'Dáng thế đẹp, hợp phong thủy, lâu năm.', 10, 4.8, 3),
('Cây Bonsai Sanh Mini', 280000, 'https://img.thuthuattinhoc.vn/uploads/2019/04/10/cay-canh-mini-dep_112734611.jpg', 'Dáng cổ, rễ nổi, được uốn tạo thế nghệ thuật.', 8, 4.7, 3),
('Cây Bonsai Bạch Tuyết Mai', 320000, 'https://cayvahoa.net/wp-content/uploads/2016/07/cay-bach-tuyet-mai-bonsai.jpg', 'Hoa trắng, dáng bonsai nhỏ, để bàn đẹp.', 12, 4.6, 3),

-- Sen đá - xương rồng (category_id = 4)
('Sen Đá Nâu', 50000, 'https://tse4.mm.bing.net/th/id/OIP.KM5D0QVuZapqaWt5dxZ9LAHaF0?rs=1&pid=ImgDetMain&o=7&rm=3', 'Dáng tròn, màu nâu lạ, nhỏ xinh.', 60, 4.9, 4),
('Sen Đá Viền Hồng', 55000, 'https://tse4.mm.bing.net/th/id/OIP.qDBAPTW_z048RRVjLzBwEAHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', 'Viền hồng bắt mắt, rất dễ chăm.', 50, 4.7, 4),
('Xương Rồng Tai Thỏ', 60000, 'https://vuoncayxinh.com/wp-content/uploads/2021/07/xuong-rong-tai-tho-4.jpg', 'Xương rồng dáng tai thỏ, dễ thương.', 45, 4.6, 4),
('Xương Rồng Trứng Chim', 70000, 'https://3.bp.blogspot.com/-eO3E0KbESUk/WWGfE0KGqUI/AAAAAAAACJY/P-Y6_D9Biy8WMXXQ2Qm6lsE5FsLd_qj4gCLcBGAs/s1600/xuong-rong-trung-chim2.jpg', 'Nhỏ gọn, dáng tròn như trứng chim.', 55, 4.5, 4),
('Sen Đá Lá Hoa Hồng', 65000, 'https://tse1.mm.bing.net/th/id/OIP.CYAk-jVPL_WmNUgD32yBGAAAAA?rs=1&pid=ImgDetMain&o=7&rm=3', 'Dáng hoa hồng, lá xoắn đẹp, cực xinh.', 48, 4.8, 4);

INSERT INTO cart_items (user_id, plant_id, quantity)
VALUES
    (2, 1, 2),
    (2, 3, 1),
    (3, 2, 3);

INSERT INTO orders (user_id, address_id, total_amount, status)
VALUES
    (2, 1, 350000, 'processing'),
    (3, 2, 300000, 'pending');

INSERT INTO reviews (user_id, plant_id, rating, comment)
VALUES
    (2, 1, 5, 'Cây đẹp, tươi tốt, giao nhanh.'),
    (3, 2, 4, 'Dễ chăm, nhưng lá hơi nhỏ hơn hình.');

INSERT INTO wishlist (user_id, plant_id)
VALUES
    (2, 2),
    (2, 3),
    (3, 1);









