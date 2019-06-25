# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in (0..5)
  Photo.create([
    {
      picture_link: "www.abc.com.vn",
      status_title: "New status",
      status: "lorem spectrum bla bla bla",
      time: Time.now,
      like: 69,
      user_id: 1,
      is_public: true,
    },
  ])

  Album.create([
    {
      name: i.to_s + "_Album",
      time: Time.now,
      like: 696,
      is_public: true,
    },
  ])
end
