require 'mime-types'

class Static
  def initialize(app)
    @app = app
  end

  def call(env)
    path = ".#{env['PATH_INFO']}"
    if path.include?("public")
      ext = File.extname(path)
      mime_type = MIME::Types.type_for(ext[1..-1])

      if mime_type && File.exists?(path)

        return ["200", {'Content-type' => mime_type}, File.read(path)]
      else
        return ["404", {'Content-type' => 'text/html'}, ["file not found"]]
      end
    else
      @app.call(env)
    end
  end
end
