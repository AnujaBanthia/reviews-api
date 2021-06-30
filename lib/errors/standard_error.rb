module Errors
  class StandardError < ::StandardError

    attr_reader :title, :detail, :status

    def initialize(title: nil, detail: nil, status: nil, source: {})
      @title = title || 'Something went wrong'
      @detail = detail || 'We encountered unexpected error, but our developers had been already notified about it'
      @status = status || 500
    end

    def to_json
        {
            status: status,
            title: title,
            detail: detail
          }
    end
  end
end
