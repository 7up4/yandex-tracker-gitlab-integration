class MergeRequestReferencingWorker
  include Sidekiq::Worker

  def perform(id, ref, action)
    case action
    when "add"
      Issues::Reference::MergeRequest::Add.call(issue_id: id, reference: ref)
    when "remove"
      Issues::Reference::MergeRequest::Remove.call(issue_id: id, reference: ref)
    end
  end
end