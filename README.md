# Vehicle Rental System - Database Design & SQL Queries

## 🚗 Overview
This project is a **Vehicle Rental System** database assignment designed to demonstrate knowledge of:
- Database table design  
- Entity Relationship Diagram (ERD)  
- SQL queries using JOIN, EXISTS, WHERE, GROUP BY, and HAVING  

The system manages:
- **Users**  
- **Vehicles**  
- **Bookings**  

---

## 🗂 Database Design & Business Logic

### Users Table
Stores user information:
- `user_id` (Primary Key)
- `name`  
- `email` (Unique)  
- `phone`  
- `role` (Admin / Customer)

### Vehicles Table
Stores vehicle information:
- `vehicle_id` (Primary Key)  
- `name`  
- `type` (car / bike / truck)  
- `model`  
- `registration_number` (Unique)  
- `rental_price`  
- `status` (available / rented / maintenance)

### Bookings Table
Stores booking information:
- `booking_id` (Primary Key)  
- `user_id` (Foreign Key → Users.user_id)  
- `vehicle_id` (Foreign Key → Vehicles.vehicle_id)  
- `start_date`  
- `end_date`  
- `status` (pending / confirmed / completed / cancelled)  
- `total_cost`  

---

## 📝 Entity Relationship Diagram (ERD)
The ERD shows the relationships between tables:
- **One-to-Many:** Users → Bookings  
- **Many-to-One:** Bookings → Vehicles  
- **One-to-One (logical):** Each booking links one user to one vehicle  

**Note:** ERD submitted via Lucidchart (public shareable link included in submission).

---

## 💾 Sample Data

### Users Table
| user_id | name    | email             | phone       | role     |
|--------:|---------|-----------------|------------|---------|
| 1       | Alice   | alice@example.com | 1234567890 | Customer|
| 2       | Bob     | bob@example.com   | 0987654321 | Admin   |
| 3       | Charlie | charlie@example.com | 1122334455 | Customer|

### Vehicles Table
| vehicle_id | name          | type  | model | registration_number | rental_price | status      |
|-----------:|---------------|-------|-------|-------------------|-------------|------------|
| 1          | Toyota Corolla| car   | 2022  | ABC-123           | 50          | available  |
| 2          | Honda Civic   | car   | 2021  | DEF-456           | 60          | rented     |
| 3          | Yamaha R15    | bike  | 2023  | GHI-789           | 30          | available  |
| 4          | Ford F-150    | truck | 2020  | JKL-012           | 100         | maintenance|

### Bookings Table
| booking_id | user_id | vehicle_id | start_date  | end_date    | status     | total_cost |
|-----------:|--------:|-----------:|------------|------------|-----------|------------|
| 1          | 1       | 2          | 2023-10-01 | 2023-10-05 | completed | 240        |
| 2          | 1       | 2          | 2023-11-01 | 2023-11-03 | completed | 120        |
| 3          | 3       | 2          | 2023-12-01 | 2023-12-02 | confirmed | 60         |
| 4          | 1       | 1          | 2023-12-10 | 2023-12-12 | pending   | 100        |

---

## 🔍 SQL Queries

### Query 1: JOIN
Retrieve booking info along with customer name and vehicle name.
```sql
SELECT b.booking_id, u.name AS customer_name, v.name AS vehicle_name,
       b.start_date, b.end_date, b.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN vehicles v ON b.vehicle_id = v.vehicle_id;
```

### Query 2: NOT EXISTS

Find all vehicles that have never been booked.
```
SELECT *
FROM vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id
);
```

### Query 3: WHERE

Retrieve all available vehicles of type 'car'.
```
SELECT *
FROM vehicles
WHERE status = 'available'
  AND type = 'car';
```
### Query 4: GROUP BY & HAVING

Find vehicles with more than 2 bookings.
```
SELECT v.name AS vehicle_name, COUNT(b.booking_id) AS total_bookings
FROM vehicles v
JOIN bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;
```


## 🎓 Viva Questions 

### 1️⃣ Foreign Key কি? কেন গুরুত্বপূর্ণ?
- Foreign key হলো একটি column যা অন্য table-এর **primary key** refer করে।  
- এটি নিশ্চিত করে যে **database-এ ভুল data insert হবে না**।  
- সহজভাবে: table-এর মধ্যে **relationship এবং data integrity** বজায় রাখে।  

---

### 2️⃣ WHERE এবং HAVING-এর পার্থক্য কি?
- **WHERE**: row-level filter করে, **GROUP BY-এর আগে**।  
- **HAVING**: group-level filter করে, **aggregation (COUNT, SUM, AVG) করার পরে**।  
- সহজভাবে: WHERE → কোন row নিবো, HAVING → কোন group দেখাবো।  

---

### 3️⃣ Primary Key কি? বৈশিষ্ট্য কী?
- Primary key হলো table-এর main column যা **প্রতিটি row আলাদা করে চিনে**।  
- বৈশিষ্ট্য:  
  - Unique হতে হবে  
  - NULL হতে পারবে না  
  - table-এ শুধুমাত্র একটি primary key থাকতে পারে  

---

### 4️⃣ INNER JOIN এবং LEFT JOIN-এর পার্থক্য কি?
- **INNER JOIN**: শুধু দুই table-এর **matching rows** দেখায়।  
- **LEFT JOIN**: left table-এর সব row দেখায়, match না থাকলে right table থেকে **NULL** দেখায়।  
- সহজভাবে:  
  - INNER JOIN → match করা data  
  - LEFT JOIN → left table-এর সব data
