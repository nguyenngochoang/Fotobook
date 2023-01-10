require 'rails_helper'

describe PhotosController do
  context 'when users like a photo' do
    it 'go to photo_like path' do
      
      expect(patch: "/photo_like").to route_to(controller: "photos", action: "photo_like")

      expect { patch :photo_like, params:{act: "like", gallery_id: 2} }.to change {Like.count}.by(1)




    end

    # it 'push users_id to likes array of photos' do
    #   @photo = Photo.find(2)
    #   rand_id = rand 100000
    #   expect {
    #     @photo.likes.push(rand_id)
    #     @photo.save
    #   }.to change{@photo.likes.count}.by(1)
    # end
  end
end