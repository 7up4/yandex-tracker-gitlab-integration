module YandexTrackerApi
  class Result
    def process
      extract_result
    end

    private

    def initialize(response:, request:)
      @response = response
      @request = request
    end

    attr_reader :response, :request

    def extract_result
      data = response.body

      if response.status.to_s[0] != "2" # data[:code] != "SUCCESS"
        raise YandexTrackerApi::Error.new(
          code: data[:statusCode],
          message: [data[:errors].values, data[:errorMessages], request.inspect].flatten.join(","),
          response: response,
          request: request,
        )
      else
        data
      end
    end
  end
end
