class UrlMailer < ActionMailer::Base
  default from: "luise.rauch@gmail.com"

  def oops(user, bookmark)

  headers["In-Reply-To"] = "<bookmark/#{bookmark.id}@your-app-name.example>"
  headers["References"] = "<bookmark/#{bookmark.id}@your-app-name.example>"

  @user = user
  @bookmark = bookmark

  mail(to: user.email, subject: "We couldn't add your bookmark #{bookmark.url}.")
end
end
