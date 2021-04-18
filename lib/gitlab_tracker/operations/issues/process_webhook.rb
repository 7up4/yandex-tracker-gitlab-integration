module Issues
  class ProcessWebhook
    def self.call(**params)
      new(**params).call
    end

    def call
      case object_kind
      when "merge_request"
        ProcessMergeRequest.call(attributes)
      end
    end

    private

    attr_reader :attributes, :object_kind

    def initialize(attributes)
      @attributes = attributes
      @object_kind = attributes[:object_kind]
    end
  end
end
