RSpec.shared_examples_for 'all admin pages' do
  describe 'navbar' do
    it { should have_selector 'nav.navbar' }
    it { should have_link I18n.t('brand'), href: root_path(locale: I18n.locale) }

    describe 'locale' do
      it { should have_link 'Русский' }
      it { should have_link 'English' }
    end
  end
end
