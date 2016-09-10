require 'rails_helper'

RSpec.describe Admin::CommentsController, :type => :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/comments').to route_to('admin/comments#index')
    end

    it 'routes to #show' do
      expect(get: '/admin/comments/1').to route_to('admin/comments#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/admin/comments/1/edit').to route_to('admin/comments#edit', id: '1')
    end

    it 'routes to #update' do
      expect(put: '/admin/comments/1').to route_to('admin/comments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/comments/1').to route_to('admin/comments#destroy', id: '1')
    end

    it 'routes to #publish' do
      expect(post: '/admin/comments/1/publish').to route_to('admin/comments#publish', id: '1')
    end

    it 'routes to #unpublish' do
      expect(post: '/admin/comments/1/unpublish').to route_to('admin/comments#unpublish', id: '1')
    end
  end
end
