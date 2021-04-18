class IssueTransitioningWorker
  include Sidekiq::Worker

  def perform(issue_id, transition_id)
    case transition_id
    when "resolve"
      Issues::Transition::Resolve.call(issue_id: issue_id)
    end
  end
end