FactoryBot.define do
  factory :user do
    email { 'linh_ptt@gmail.com' }
    password { '123456' }
    first_name {'Linh'}
    last_name {'Pham Thi Tuyet'}
    avatar {'sample2.jpeg'}

    # using dynamic attributes over static attributes in FactoryBot

    # if needed
    # is_active true
  end
end