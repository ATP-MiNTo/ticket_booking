# Ticket API

## วิธีรันโปรเจค
```sh
bundle install
bin/rails db:create db:migrate
bin/rails s
```

## เพิ่มข้อมูลเข้าไปในฐานข้อมูลด้วย `rails c`
```sh
bin/rails c
```

ตัวอย่างการเพิ่มข้อมูล:
```ruby
event = Event.create!(name: "The toys", date: Time.current, capacity: 100)
event.bookings.create!(email: "user@example.com", quantity: 2)
```

## วิธีจัดการ concurrency
ล็อค event และทำการเช็กจำนวนตั๋วกับการสร้าง booking ใน transaction เดียวเพื่อป้องกันการขายตั๋วเกินจากที่มีจริง ถึงแม้จะต้องแลกด้วยประสิทธิภาพที่ลดลงและความซับซ้อนที่มากขึ้น

## ถ้ามีเวลาเพิ่ม
- เพิ่ม request tests และ model tests สำหรับ flow การจอง เนื่องจากปัจจุบันไม่มีการเขียนเทสไว้
- refactor ระบบ validation และ error response ให้ผู้ใช้เข้าใจได้ง่ายขึ้น
- ทำให้ field ที่จำเป็นเป็น non-null ใน schema และเพิ่ม model validations ให้สอดคล้องกัน
- ใช้การ preload หรือ aggregate จำนวน booking เพื่อประสิทธิภาพกรณีที่ฐานข้อมูลมีขนาดใหญ่ขึ้น เพื่อลดปัญหา N+1 query ในหน้า events index


### How to run the project
```sh
bundle install
bin/rails db:create db:migrate
bin/rails s
```

### Add data with `rails c`
```sh
bin/rails c
```

Example:
```ruby
event = Event.create!(name: "The toys", date: Time.current, capacity: 100)
event.bookings.create!(email: "user@example.com", quantity: 2)
```

### Concurrency handling
Lock the event and check ticket availability and create the booking in the same transaction to prevent overselling. This trades off some performance and adds a bit of complexity.

### If I had more time
- Add request tests and model tests for the booking flow, since there are currently no tests for it.
- Refactor validation and error responses to make them easier for users to understand.
- Make required fields non-null in the schema and add matching model validations.
- Use preloading or aggregation for booking counts to improve performance as the database grows to reduce the N+1 query problem in the events index.