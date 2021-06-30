module Errors
  class Unauthorized < Errors::StandardError
    def initialize
      super(
        title: 'Unauthorized',
        status: 401,
        detail: detail || 'You are not authorized to this request.'
      )
    end
  end
end
