module YandexTrackerApi
  class Error < StandardError
    attr_reader :code, :message, :request, :response

    private

    def initialize(message:, request:, response:, code: nil)
      @code = code || response.status
      @message = message || "Код ошибки #{@code}"
      @response = response
      @request = request
    end
  end
end
