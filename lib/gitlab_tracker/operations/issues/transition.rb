module Issues
  class Transition
    def self.call(**params)
      new(**params).call
    end

    def call
      find_issues
      make_transitions
    end

    private

    attr_reader :description, :resolvable_issue_ids

    def initialize(description:)
      @description = description
    end

    def find_issues
      issues_to_resolve
    end

    def make_transitions
      resolve_issues
    end

    def issues_to_resolve
      @resolvable_issue_ids = FetchFromDescription.call(description: description, type: :resolve)
    end

    def resolve_issues
      resolvable_issue_ids.each { |id| IssueTransitioningWorker.perform_async(id, "resolve") }
    end
  end
end