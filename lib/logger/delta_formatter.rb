class DeltaFormatter < Logger::Formatter
    def call(severity, time, program_name, msg)
        "[#{severity}] #{String === msg ? msg : msg.inspect}\n"
    end
end
