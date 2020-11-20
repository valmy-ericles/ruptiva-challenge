puts "add a root admin"

User.create!(
  first_name: 'admin', 
  last_name: 'admin',
  email: 'admin@admin.com',
  role: :admin,
  password: 'admin12345678',
  password_confirmation: 'admin12345678',
)

puts "root admin added"
