class CustomLogger < Logger
  def format_message severity, timestamp, progname, msg
    "#{timestamp.to_formatted_s(:db)} #{msg}\n"
  end
end

logfile = File.open("#{Rails.root}/log/admin.log", "a")
logfile.sync = true
CUSTOM_LOGGER = CustomLogger.new(logfile)
