module Hook
  include Rails.application.routes.url_helpers
  delegate :default_url_options, to: ActionMailer::Base

  def callback_url
    Rails.env.production? ? github_webhooks_url(host: ENV['HOST'], protocol: ENV['PROTOCOL']) : github_webhooks_url(host: ENV['ULTRAHOOK'], port: 80)
  end

  def push_url(project)
    "https://github.com/#{project.repo}/events/push.json"
  end
end