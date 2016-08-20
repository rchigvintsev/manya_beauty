require 'rails_helper'

RSpec.describe Admin::PhotoAlbumsController, :type => :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/photo_albums').to route_to('admin/photo_albums#index')
    end

    it 'routes to #new' do
      expect(get: '/admin/photo_albums/new').to route_to('admin/photo_albums#new')
    end

    it 'routes to #show' do
      expect(get: '/admin/photo_albums/1').to route_to('admin/photo_albums#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/photo_albums/1/edit').to route_to('admin/photo_albums#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/admin/photo_albums').to route_to('admin/photo_albums#create')
    end

    it 'routes to #update' do
      expect(put: '/admin/photo_albums/1').to route_to('admin/photo_albums#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/photo_albums/1').to route_to('admin/photo_albums#destroy', id: '1')
    end
  end
end
