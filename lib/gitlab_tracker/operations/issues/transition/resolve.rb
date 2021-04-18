module Issues
  class Transition
    class Resolve
      def self.call(**params)
        new(**params).call
      end

      def call
        if resolvable?
          resolve_issue
        end
      end

      private

      attr_reader :issue_id, :transition_id


      def initialize(issue_id:)
        @issue_id = issue_id
        @transition_id = "resolve"
      end

      def resolvable?
        transitions = YandexTrackerApi::Actions::GetTransitions.call(issue_id)
        transitions.detect { |transition| transition[:id] == transition_id }
      end

      def resolve_issue
        YandexTrackerApi::Actions::ExecuteTransition.call(issue_id: issue_id, transition_id: transition_id)
      rescue YandexTrackerApi::Error => e
        raise e if e.code != 404

        return true
      end
    end
  end
end
