class BadWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    Rollbar.scope!(person: {id: user_id})

    some_bad_method(user_id)
  end

  def some_bad_method(user_id)
    raise "This is an exception"
  end
end
