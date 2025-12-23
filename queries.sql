-- query 1
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



-- query 2
SELECT
vehicle_id,name,type,model,registration_number,rental_price,status 
FROM vehicles WHERE NOT EXISTS 
(SELECT vehicle_id FROM bookings WHERE bookings.vehicle_id = vehicles.vehicle_id)



-- query 3
SELECT * FROM vehicles WHERE status = 'available' AND TYPE = 'car'



--- query 4
SELECT
  vehicles.name as vehicle_name,
  count(bookings.vehicle_id) as total_bookings
FROM
  vehicles
  join bookings ON vehicles.vehicle_id = bookings.vehicle_id
GROUP BY
  vehicles.name
HAVING  2 < count(bookings.vehicle_id)