module Api
  module Controllers
    module Issues
      class Webhook
        include Api::Action

        before :authenticate!

        params do
          required(:object_kind).filled(:str?, included_in?: %w(merge_request))
        end

        def call(params)
          ::Issues::ProcessWebhook.call(params) if params.valid?

          self.body = 'OK'
        end

        private

        def authenticate!
          halt 401 unless authenticated?
        end

        def authenticated?
          request.env['HTTP_X_GITLAB_TOKEN'] == ENV['GITLAB_WEBHOOK_TOKEN']
        end
      end
    end
  end
end
