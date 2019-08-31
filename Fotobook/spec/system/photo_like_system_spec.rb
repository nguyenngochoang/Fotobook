require 'rails_helper'

describe 'Users like photo', type: :system do
  scenario 'users press on like button ' do
    user_main = FactoryBot.create(:user)
    user_2 = User.create(email:"ohnbmgkfehfewjklll@gmail.com", password:"123456", first_name:"mrA", last_name:"Wick")
    p = user_2.photos.new(attached_image:"sample.jpg",title:"I'm here",description:"fdsjalfkdsj", sharing_mode: 'true')
    p.save
    user_main.followees.push(user_2)
    sign_in(user_main)


    visit root_path
    find('.heart-animation').click
    expect {page.to have_css('.liked')}

    Warden.test_reset!
  end

end