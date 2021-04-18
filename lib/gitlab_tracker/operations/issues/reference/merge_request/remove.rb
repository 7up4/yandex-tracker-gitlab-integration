module Issues
  class Reference
    class MergeRequest
      class Remove
        def self.call(**params)
          new(**params).call
        end

        def call
          remove_reference
        end

        private

        attr_reader :issue_id, :reference

        def initialize(issue_id:, reference:)
          @issue_id = issue_id
          @reference = reference
        end

        def remove_reference
          YandexTrackerApi::Actions::Modify.call(issue_id: issue_id, params: { mergeRequest: nil })
        rescue YandexTrackerApi::Error => e
          raise e if e.code != 404

          return true
        end
      end
    end
  end
end
