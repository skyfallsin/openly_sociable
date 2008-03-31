require '../../lib/openly_sociable_micro'

OpenSocial.make_app :HelloWorld

module HelloWorld::Controllers
  class Index < R '/'
    def get
      @title = "Hello World"
      render :index
    end
  end
end

module HelloWorld::Views
  def index
    p "Hello World"
  end
end

OpenSocial.start_mongrel :HelloWorld, :port => 3301, :root => "/"