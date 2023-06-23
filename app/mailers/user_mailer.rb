class UserMailer < ApplicationMailer
  def account_activated
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome')
  end

  def registered
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Registered successfully')
  end

  def good_morning
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Good Morning')
  end

  def happy_birthday
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Happy Birthday!!')
  end
end
