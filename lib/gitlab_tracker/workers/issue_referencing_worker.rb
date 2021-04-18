class IssueReferencingWorker
  include Sidekiq::Worker

  def perform(id, ref, created_at)
    Issues::Reference::Comment.call(issue_id: id, reference: ref, created_at: created_at, created_by: ENV.fetch('YANDEX_TRACKER_LOGIN'))
  end
end
