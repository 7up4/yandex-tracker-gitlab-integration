module Issues
  class Reference
    class Comment
      def self.call(**params)
        new(**params).call
      end

      def call
        add_reference
      end

      private

      attr_reader :issue_id, :reference, :created_at, :created_by

      def initialize(issue_id:, reference:, created_at:, created_by:)
        @issue_id = issue_id
        @reference = reference
        @created_at = created_at
        @created_by = created_by
      end

      def add_reference
        YandexTrackerApi::Actions::ImportComment.call(issue_id: issue_id, params: { text: text, created_at: created_at, created_by: created_by })
      rescue YandexTrackerApi::Error => e
        raise e if e.code != 404

        return true
      end

      def text
        "Задача была упомянута в #{reference}"
      end
    end
  end
end
