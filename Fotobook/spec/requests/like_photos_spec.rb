require 'rails_helper'

RSpec.describe "LikePhotos", type: :request do
  describe "PATCH /photo_like" do
    it "should change like's user id list" do
      user_main = FactoryBot.create(:user)
      user_2 = User.create(email:"ohnbmgkfehfewjklll@gmail.com", password:"123456", first_name:"mrA", last_name:"Wick")
      p = user_2.photos.create(
        attached_image: "sample.jpg",
        title: "I'm here",
        description: "fdsjalfkdsj",
        sharing_mode: true
      )

      sign_in(user_main)
      expect {
        patch('/photo_like', xhr: true, params: {act: "likes", gallery_id: p.id })
      }.to change { p.reload.likes.count }.by(1) #xhr : true => test response_to format js
    end
  end
end
