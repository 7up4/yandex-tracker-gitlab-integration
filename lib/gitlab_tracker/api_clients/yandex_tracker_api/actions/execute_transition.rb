module YandexTrackerApi
  module Actions
    class ExecuteTransition
      def self.call(issue_id:, transition_id:)
        API.post(path: "issues/#{issue_id}/transitions/#{transition_id}/_execute")
      end
    end
  end
end
