class TopicMailer < ActionMailer::Base
  default from: "luise.rauch@gmail.com"

  def ohno(user, topic)

    headers["In-Reply-To"] = "<topic/#{topic.id}@your-app-name.example>"
    headers["References"] = "<topic/#{topic.id}@your-app-name.example>"

    @user = user
    @topic = topic

    mail(to: user.email, subject: "We couldn't add your topic #{topic.title}.")
  end
end
