CREATE TABLE users(
  user_id INT PRIMARY KEY,
  name VARCHAR(50) not null,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(50) NOT NULL,
  role VARCHAR(20) NOT NULL CHECK (role IN ('admin','customer')) 
);



CREATE TABLE vehicles(
  vehicle_id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  type VARCHAR(50) NOT NULL CHECK(type IN ('car','bike','truck')),
  model VARCHAR(20) NOT NULL,
  registration_number VARCHAR(50) NOT NULL UNIQUE,
  rental_price VARCHAR(20) NOT NULL,
  status VARCHAR(50) NOT NULL CHECK (status IN ('available','rented','maintenance'))
);


CREATE TABLE bookings(
  booking_id INT PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
  vehicle_id INT NOT NULL REFERENCES vehicles(vehicle_id) ON DELETE CASCADE,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (status IN ('pending','confirmed','completed','cancelled')),
  total_cost VARCHAR(20) NOT NULL
);

INSERT INTO users (user_id, name, email, phone, role) VALUES
(1, 'Alice', 'alice@example.com', '1234567890', 'customer'),
(2, 'Bob', 'bob@example.com', '0987654321', 'admin'),
(3, 'Charlie', 'charlie@example.com', '1122334455', 'customer');


INSERT INTO vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) VALUES
(1, 'Toyota Corolla', 'car', '2022', 'ABC-123', '50', 'available'),
(2, 'Honda Civic', 'car', '2021', 'DEF-456', '60', 'rented'),
(3, 'Yamaha R15', 'bike', '2023', 'GHI-789', '30', 'available'),
(4, 'Ford F-150', 'truck', '2020', 'JKL-012', '100', 'maintenance');


INSERT INTO bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', '240'),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', '120'),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed', '60'),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending', '100');






SELECT 
  booking_id,
  users.name as customer_name ,
  vehicles.name as vehicle_name,
  start_date,
  end_date,
  bookings.status
  FROM bookings
JOIN users ON bookings.user_id = users.user_id 
JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id






