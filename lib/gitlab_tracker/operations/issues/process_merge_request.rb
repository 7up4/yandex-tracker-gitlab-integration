module Issues
  class ProcessMergeRequest
    def self.call(**params)
      new(**params).call
    end

    def call
      if merged?
        Transition.call(description: object_attributes.dig(:description))
      elsif description_changed?
        Reference.call(changes: changes, merge_request_url: merge_request_url)
      end
    end

    private

    attr_reader :object_attributes, :changes, :merge_request_url

    def initialize(attributes)
      @object_attributes = attributes[:object_attributes]
      @changes = attributes[:changes]
      @merge_request_url = attributes.dig(:object_attributes, :url)
    end

    def merged?
      changes&.dig(:state_id, :current) == 3
    end

    def description_changed?
      changes&.dig(:description)
    end
  end
end
