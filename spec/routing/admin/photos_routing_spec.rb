require 'rails_helper'

RSpec.describe Admin::PhotosController, :type => :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/photos').to route_to('admin/photos#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/photos/new').to route_to('admin/photos#new')
    end

    it 'routes to #show' do
      expect(get: '/admin/photos/1').to route_to('admin/photos#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/photos/1/edit').to route_to('admin/photos#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/photos').to route_to('admin/photos#create')
    end

    it 'routes to #update' do
      expect(put: '/admin/photos/1').to route_to('admin/photos#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/photos/1').to route_to('admin/photos#destroy', id: '1')
    end
  end
end
