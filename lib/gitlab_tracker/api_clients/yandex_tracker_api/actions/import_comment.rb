module YandexTrackerApi
  module Actions
    class ImportComment
      def self.call(issue_id:, params:)
        API.post(path: "issues/#{issue_id}/comments/_import", params: RequestMappers::ImportComment.call(params))
      end
    end
  end
end
