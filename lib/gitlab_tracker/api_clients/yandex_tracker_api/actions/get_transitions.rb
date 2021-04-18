module YandexTrackerApi
  module Actions
    class GetTransitions
      def self.call(issue_id)
        API.get(path: "issues/#{issue_id}/transitions")
      end
    end
  end
end
