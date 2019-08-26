require 'factory_bot'
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
module LoginBot
  def login_as(user)
    request.session[:user_id] = user.id
  end

end