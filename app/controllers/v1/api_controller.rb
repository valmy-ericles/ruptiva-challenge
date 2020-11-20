module V1
  class ApiController < ApplicationController
    include Authenticable
    include SimpleErrorRenderable
    include Pundit

    self.simple_error_partial = 'shared/simple_error'
  end
end
