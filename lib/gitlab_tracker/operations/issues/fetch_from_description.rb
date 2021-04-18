module Issues
  class FetchFromDescription
    ISSUE_ID_REGEX = /(([A-Z][A-Z0-9_]+)-\d+)/
    CLOSING_REGEX = /((?:[Cc]los(?:e[sd]?|ing)|[Ff]ix(?:e[sd]|ing)?|[Rr]esolv(?:e[sd]?|ing)|[Ii]mplement(?:s|ed|ing)?)):? +(?:issues? +)?((?:#{ISSUE_ID_REGEX}(?:(?:, *| +and +)?))+)/

    def self.call(**params)
      new(**params).call
    end

    def call
      case @type
      when :resolve
        issues_to_resolve || []
      when :reference
        issues_to_reference || []
      end
    end

    private

    attr_reader :description

    def initialize(description:, type:)
      @description = description
      @type = type
    end

    def issues_to_resolve
      if description
        description.scan(CLOSING_REGEX).map { |groups| groups[1].scan(ISSUE_ID_REGEX).map(&:first) }.flatten.uniq
      end
    end

    def issues_to_reference
      if description
        description.scan(ISSUE_ID_REGEX).map(&:first).uniq - issues_to_resolve
      end
    end
  end
end