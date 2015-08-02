RSpec.shared_examples_for "all admin pages" do
  describe "navbar" do
    it { should have_selector 'nav.navbar' }
    it { should have_link I18n.translate('brand'),
        href: root_path(locale: I18n.locale) }
  end
end
