require '../../lib/openly_sociable_micro'

OpenSocial.make_app :ListFriends

module ListFriends::Controllers
  class Index < R '/'
    def get
      @title = "Friend List"
      render :index
    end
  end
end

module ListFriends::Views
  def index
    javascript :friends
    div(:id => "message")
  end
end

OpenSocial.start_mongrel :ListFriends, :port => 3301, :root => "/"