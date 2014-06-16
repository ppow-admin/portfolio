#!/usr/bin/ruby
#
#Simple mailer program in Ruby written as part of the ALARM call in the confluence backup script
#
#
#


class Mailer
    attr_accessor :footer
    def initialize(host,port=25)
      require 'net/smtp'
      require 'socket'
      @mailsrv = host
      @mailport = port
      @footer = ["Produced by #{$0} on #{Socket.gethostname}"]
    end

    def send(subject, body, recipients, sender)
      warn "Mailing via #{@mailsrv}:#{@mailport} to #{recipients.join(',')}"
      Net::SMTP.start(@mailsrv, @mailport) do |smtp|
        smtp.open_message_stream(sender, recipients) do |f|
          f.puts 'From:  ' + sender
          f.puts 'To: ' + recipients.join(',')
          f.puts 'Subject: ' + subject
          f.puts
          f.puts body.join('\n')
          f.puts "\n" + @footer.join('\n')
        end
    end
  end
end



subject = ARGV.shift
recipients = ['sfloyd@domain.com']
lines = []
until ARGV.empty? do
  recipients << ARGV.shift
end

while line = gets
  lines << line
end

sender='root@domain.com'
smtphost = 'mta01.atld1'
mta = Mailer.new("mta01.atld1")
mta.send(subject, lines, recipients, sender)