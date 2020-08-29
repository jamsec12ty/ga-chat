# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ------------------------- User ------------------------- #

User.destroy_all

u1 = User.create!(
  email: "xinpf0715@gmail.com",
  password: "chicken",
  name: "Ryan"
)

u2 = User.create!(
  email: "luke@ga.co",
  password: "chicken",
  name: "Luke"
)

u3 = User.create!(
  email: "zara@ga.co",
  password: "chicken",
  name: "Zara"
)

u4 = User.create!(
  email: "kate@ga.co",
  password: "chicken",
  name: "Kate"
)

puts "Created #{User.count} users."

# ------------------------ Message ----------------------- #

Message.destroy_all

m1 = Message.create!(
  sender_id: u1.id,
  recipient_id: u2.id,
  content: "Hi Luke, you are so creative!"
)

m2 = Message.create!(
  sender_id: u2.id,
  recipient_id: u1.id,
  content: "How are you?"
)

m3 = Message.create!(
  sender_id: u1.id,
  recipient_id: u4.id,
  content: "Wazzzzzzzzzzap!!!!"
)

m4 = Message.create!(
  sender_id: u2.id,
  recipient_id: u3.id,
  content: "Lek shu habibi"
)

m5 = Message.create!(
  sender_id: u3.id,
  recipient_id: u2.id,
  content: "大家好，周末愉快！"
)

puts "Created #{Message.count} messages."

# ---------------------- Friend --------------------- #

Friend.destroy_all

f1 = Friend.create!(
  userA_id: u1.id,
  userB_id: u3.id,
  status: "confirmed"
)

f2 = Friend.create!(
  userA_id: u1.id,
  userB_id: u2.id,
  status: "confirmed"
)

f3 = Friend.create!(
  userA_id: u1.id,
  userB_id: u4.id,
  status: "pending"
)

f4 = Friend.create!(
  userA_id: u2.id,
  userB_id: u3.id,
  status: "confirmed"
)

f5 = Friend.create!(
  userA_id: u3.id,
  userB_id: u4.id,
  status: "blocked"
)

puts "Created #{Friend.count} friends."
puts "Created user: #{u1.id}"

# ---------------------- Association --------------------- #

# u1.friends << f1 << f2 << f3
# u2.friends << f4
# u3.friends << f5