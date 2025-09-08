-- Insert sample categories
INSERT INTO categories (name, description) VALUES 
('Cây văn phòng', 'Các loại cây phù hợp để trang trí văn phòng'),
('Cây thủy sinh', 'Cây được trồng trong môi trường nước'),
('Cây bonsai', 'Cây cảnh được tạo dáng theo nghệ thuật bonsai'),
('Sen đá - Xương rồng', 'Các loại cây sen đá và xương rồng dễ chăm sóc');

-- Insert sample plants
INSERT INTO plants (name, category_id, price, stock, image_url, description, is_active, rating_avg) VALUES 
('Cây Kim Tiền', 1, 150000, 25, 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400', 'Cây kim tiền mang ý nghĩa may mắn, thịnh vượng. Dễ chăm sóc, phù hợp văn phòng.', true, 4.5),
('Cây Trầu Bà', 1, 80000, 30, 'https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=400', 'Cây trầu bà lá xanh đẹp, khả năng lọc không khí tốt.', true, 4.2),
('Cây Lưỡi Hổ', 1, 120000, 20, 'https://images.unsplash.com/photo-1509315811345-672d83ef2fbc?w=400', 'Cây lưỡi hổ có khả năng thanh lọc không khí, chịu được ánh sáng yếu.', true, 4.6),
('Sen Đá Nâu', 4, 50000, 40, 'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400', 'Sen đá nâu nhỏ gọn, dễ chăm sóc, phù hợp để bàn.', true, 4.3),
('Xương Rồng Kim Thiên Lý', 4, 75000, 15, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400', 'Xương rồng độc đáo với hình dáng kim thiên lý.', true, 4.1),
('Bonsai Tùng La Hán', 3, 350000, 8, 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400', 'Bonsai tùng la hán được tạo dáng đẹp, phù hợp làm quà tặng.', true, 4.8),
('Cây Thủy Sinh Nhỏ', 2, 45000, 35, 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400', 'Cây thủy sinh trong bình thủy tinh nhỏ, trang trí đẹp.', true, 4.0),
('Cây Dương Xỉ', 1, 90000, 22, 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=400', 'Cây dương xỉ lá nhỏ xinh, thích hợp trong nhà.', false, 3.9);

