module ApplicationHelper

  def greet_user(user)
    if user.present?
      I18n.t('welcome_with_name', :name => current_user.username)
    else
      I18n.t('welcome')
    end
  end

  def inline_errors_messages(messages)
    if messages.present?
      template, list = '', ''
      messages.each do |message|
        list << content_tag(:li, message)
      end
      template << content_tag(:ul) do
        raw list
      end
      template.html_safe
    end
  end

end
