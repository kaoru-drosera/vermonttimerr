class ApplicationController < ActionController::Base
  def hello
    render html: "<p>hello world.</p>"
  end

  include SessionsHelper
end
