module YandexTrackerApi
  module RequestMappers
    class ImportComment
      def self.call(params)
        {
          text: params[:text],
          createdAt: 1.second.ago(DateTime.parse(params[:created_at])).iso8601(3),
          createdBy: params[:created_by]
        }
      end
    end
  end
end
