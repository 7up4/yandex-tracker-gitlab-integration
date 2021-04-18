module YandexTrackerApi
  module API
    class << self
      def post(path:, params: nil)
        request(path: path, params: params, method: :post)
      end

      def put(path:, params: nil)
        request(path: path, params: params, method: :put)
      end

      def patch(path:, params: nil)
        request(path: path, params: params, method: :patch)
      end

      def get(path:, params: nil)
        request(path: path, params: params, method: :get)
      end

      def delete(path:, params: nil)
        request(path: path, params: params, method: :delete)
      end

      private

      def request(path:, method:, params: nil)
        request_options = [method, path]
        request_options << params if params
        response = connection.send(*request_options)

        YandexTrackerApi::Result.new(response: response, request: request_options).process
      end

      def connection
        uri = YandexTrackerApi.root_path
        Faraday.new(uri, headers: { "X-Org-Id" => YandexTrackerApi.organization_id }) do |builder|
          builder.request :oauth2, YandexTrackerApi.access_token, token_type: :bearer
          builder.request :multipart
          builder.request :json

          builder.response :json, :parser_options => { :symbolize_names => true }
          builder.adapter :net_http
        end
      end
    end
  end
end
