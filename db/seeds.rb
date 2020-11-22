puts "add a root admin"

User.create!(
  first_name: 'Maikel', 
  last_name: 'Bald',
  email: 'maikel@ruptiva.com',
  password: 'ilikeruptiva',
  password_confirmation: 'ilikeruptiva',
  role: :admin,
)

puts "root admin added"
