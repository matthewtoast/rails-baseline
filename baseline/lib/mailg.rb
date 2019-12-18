require 'mailgun-ruby'

class Mailg
  TEST_EMAIL = ENV['MAILGUN_TEST_EMAIL']
  FROM_EMAIL = ENV['MAILGUN_FROM_EMAIL']
  SANDBOX_DOMAIN = ENV['MAILGUN_SANDBOX_DOMAIN']
  PROD_DOMAIN = ENV['MAILGUN_PROD_DOMAIN']

  def initialize
    @client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
  end

  def get_params(recipient_email, subject_line, body_text)
    {
      from: FROM_EMAIL,
      to: get_recipient_email(recipient_email),
      subject: get_subject_line(subject_line),
      text: get_body_text(body_text, recipient_email),
    }
  end

  def get_subject_line(subject_line)
    Rails.env.production? ? subject_line : "[#{Rails.env}] #{subject_line}"
  end

  def get_recipient_email(recipient_email)
    Rails.env.production? ? recipient_email : TEST_EMAIL
  end

  def get_body_text(body_text, recipient_email)
    Rails.env.production? ? body_text : "[recipient: #{recipient_email}]\n#{body_text}"
  end

  def get_domain
    Rails.env.production? ? PROD_DOMAIN : SANDBOX_DOMAIN
  end

  def send_email(recipient_email, subject_line, body_text)
    params = get_params(recipient_email, subject_line, body_text)
    domain = get_domain
    if !Rails.env.test?
      puts "[mailgun email] (#{domain}) #{params[:to]} #{params[:subject_line]}"
      @client.send_message(domain, params)
    end
  end
end
