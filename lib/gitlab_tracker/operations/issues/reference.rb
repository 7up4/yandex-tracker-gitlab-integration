module Issues
  class Reference
    def self.call(**params)
      new(**params).call
    end

    def call
      reference_issues
    end

    private

    attr_reader :changes, :merge_request_url

    def initialize(changes:, merge_request_url:)
      @changes = changes
      @merge_request_url = merge_request_url
    end

    def reference_issues
      add_comments
      update_merge_requests
    end

    def add_comments
      comments = issue_changes(:reference)
      add_references(comments[:add])
    end

    def update_merge_requests
      merge_requests = issue_changes(:resolve).slice(:remove, :add)
      add_merge_requests(merge_requests[:add])
      remove_merge_requests(merge_requests[:remove])
    end

    def issue_changes(type)
      description_changes = changes[:description]
      previous = description_changes[:previous]
      current = description_changes[:current]
      previous_ids = FetchFromDescription.call(description: previous, type: type)
      current_ids = FetchFromDescription.call(description: current, type: type)
      {
        remove: previous_ids - current_ids,
        add: current_ids - previous_ids,
      }
    end

    def add_merge_requests(issue_ids)
      issue_ids.each do |issue_id|
        MergeRequestReferencingWorker.perform_async(issue_id, merge_request_url, "add")
      end
    end

    def remove_merge_requests(issue_ids)
      issue_ids.each do |issue_id|
        MergeRequestReferencingWorker.perform_async(issue_id, merge_request_url, "remove")
      end
    end

    def add_references(issue_ids)
      issue_ids.each do |issue_id|
        IssueReferencingWorker.perform_async(issue_id, merge_request_url, changes[:updated_at][:current])
      end
    end
  end
end