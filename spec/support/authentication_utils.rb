def sign_in(user)
  fill_in I18n.translate('sign_in.form.email'), with: user.email
  fill_in I18n.translate('sign_in.form.password'), with: user.password
  click_button I18n.translate('sign_in.form.sign_in')
end
