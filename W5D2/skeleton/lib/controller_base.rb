require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, params = {})
    @req = req
    @res = res

    @params = params

    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise if @already_built_response

    @res.set_header('Location', url)
    @res.status = 302
    @already_built_response = true

    session.store_session(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise if @already_built_response

    @res['Content-Type'] = content_type
    @res.write(content)

    @already_built_response = true

    session.store_session(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    template_file = "./views/#{self.class.to_s.underscore}/#{template_name.to_s}.html.erb"
    file_contents = File.read(template_file)
    evaluated_file = ERB.new(file_contents).result(binding)

    self.render_content(evaluated_file, "text/html")
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)

    if !@already_built_response
      self.render name
    end
  end
end
