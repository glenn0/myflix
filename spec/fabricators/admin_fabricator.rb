Fabricator(:admin) do
  email { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name}
  admin true
end