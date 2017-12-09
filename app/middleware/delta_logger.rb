class DeltaLogger
  VALID_LOG_LEVELS = [:debug, :info, :warn, :error, :fatal, :unknown]

  def initialize(app, log_level = :info)
    @app = app
    @log_level = VALID_LOG_LEVELS.include?(log_level)? log_level: :info
  end

  def call(env)
    dup._call(env)
  end

  def _call(env)
    start_time = Time.now
    @status, @headers, @response = @app.call(env)
    end_time = Time.now

    Rails.logger.send(@log_level, '*' * 50)
    Rails.logger.send(@log_level, "Request delta time: #{(end_time - start_time) * 100} msec")
    Rails.logger.send(@log_level, '*' * 50)

    [@status, @headers, @response]
  end

end
