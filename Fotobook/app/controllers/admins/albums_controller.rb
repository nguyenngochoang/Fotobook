class Admins::AlbumsController < AdminsController
  def index
    @albums = Album.page(params[:page]).order(created_at: :desc)
  end
end
