module Issues
  class Reference
    class MergeRequest
      class Add
        def self.call(**params)
          new(**params).call
        end

        def call
          add_reference
        end

        private

        attr_reader :issue_id, :reference

        def initialize(issue_id:, reference:)
          @issue_id = issue_id
          @reference = reference
        end

        def add_reference
          YandexTrackerApi::Actions::Modify.call(issue_id: issue_id, params: { mergeRequest: reference })
        rescue YandexTrackerApi::Error => e
          raise e if e.code != 404

          return true
        end
      end
    end
  end
end
