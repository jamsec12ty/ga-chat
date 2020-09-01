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
  email: "ryan@ga.co",
  password: "chicken",
  name: "Ryan"
)

u2 = User.create!(
  email: "jam@ga.co",
  password: "chicken",
  name: "Jam"
)

u3 = User.create!(
  email: "swaroop@ga.co",
  password: "chicken",
  name: "Swaroop"
)

u4 = User.create!(
  email: "kate@ga.co",
  password: "chicken",
  name: "Kate"
)

u5 = User.create!(
  email: "luke@ga.co",
  password: "chicken",
  name: "Luke"
)

u6 = User.create!(
  email: "zara@ga.co",
  password: "chicken",
  name: "Zara"
)

puts "Created #{User.count} users."

# ---------------------- Friend --------------------- #

Friendship.destroy_all

f1 = Friendship.create!(
  user_id: u1.id,
  friend_id: u3.id,
  status: "confirmed"
)

f2 = Friendship.create!(
  user_id: u1.id,
  friend_id: u2.id,
  status: "confirmed"
)

f3 = Friendship.create!(
  user_id: u1.id,
  friend_id: u4.id,
  status: "pending"
)

f4 = Friendship.create!(
  user_id: u2.id,
  friend_id: u3.id,
  status: "confirmed"
)

f5 = Friendship.create!(
  user_id: u3.id,
  friend_id: u4.id,
  status: "confirmed"
)

f6 = Friendship.create!(
  user_id: u5.id,
  friend_id: u1.id,
  status: "confirmed"
)

f7 = Friendship.create!(
  user_id: u5.id,
  friend_id: u2.id,
  status: "confirmed"
)

f8 = Friendship.create!(
  user_id: u5.id,
  friend_id: u3.id,
  status: "pending"
)

f9 = Friendship.create!(
  user_id: u6.id,
  friend_id: u1.id,
  status: "confirmed"
)

f10 = Friendship.create!(
  user_id: u6.id,
  friend_id: u3.id,
  status: "pending"
)

f11 = Friendship.create!(
  user_id: u6.id,
  friend_id: u4.id,
  status: "confirmed"
)

puts "Created #{Friendship.count} friends."

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
  content: "大家好，周末愉快!"
)

m6 = Message.create!(
  sender_id: u2.id,
  recipient_id: u1.id,
  content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
)

m7 = Message.create!(
  sender_id: u2.id,
  recipient_id: u1.id,
  content: "How are you?"
)

m8 = Message.create!(
  sender_id: u1.id,
  recipient_id: u2.id,
  content: "Wazzzzzzzzzzap!!!!Wazzzzzzzzzzap!!!!Wazzzzzzzzzzap!!!!Wazzzzzzzzzzap!!!!"
)

m9 = Message.create!(
  sender_id: u2.id,
  recipient_id: u1.id,
  content: "Lek shu habibi. Lek shu habibi. Lek shu habibi."
)

m10 = Message.create!(
  sender_id: u3.id,
  recipient_id: u1.id,
  content: "The destructuring assignment syntax is a JavaScript expression that makes it possible to unpack values from arrays, or properties from objects, into distinct variables."
)

m11 = Message.create!(
  sender_id: u2.id,
  recipient_id: u1.id,
  content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
)

m12 = Message.create!(
  sender_id: u3.id,
  recipient_id: u1.id,
  content: "Ut aliquam purus sit amet luctus venenatis lectus magna fringilla. "
)

m13 = Message.create!(
  sender_id: u1.id,
  recipient_id: u3.id,
  content: "Odio euismod lacinia at quis risus sed. Sem integer vitae justo eget magna. Nibh tellus molestie nunc non blandit massa. "
)

m14 = Message.create!(
  sender_id: u1.id,
  recipient_id: u2.id,
  content: "Fermentum posuere urna nec tincidunt praesent. In massa tempor nec feugiat nisl pretium fusce id velit. Neque sodales ut etiam sit amet nisl purus."
)

m15 = Message.create!(
  sender_id: u1.id,
  recipient_id: u2.id,
  content: "Blandit volutpat maecenas volutpat blandit aliquam etiam erat velit scelerisque."
)

puts "Created #{Message.count} messages."


# ---------------------- Association --------------------- #
