class Admins::PhotosController < AdminsController
  def index
    @photos = Photo.page(params[:page]).order(created_at: :desc)
  end
end
