module YandexTrackerApi
  module Actions
    class Modify
      def self.call(issue_id:, params: {})
        API.patch(path: "issues/#{issue_id}", params: params)
      end
    end
  end
end
