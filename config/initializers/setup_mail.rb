ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    authentication: "plain",
    user_name: "name",
    password: "password",
    enable_starttls_auto: true
}
