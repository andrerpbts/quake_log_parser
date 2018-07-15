require 'rails_helper'

RSpec.describe Admin::AdminUsersController, type: :controller do
  let(:admin_user) { create :admin_user }

  before { sign_in admin_user }

  describe 'GET index' do
    it 'returns http success' do
      get :index

      expect(response).to have_http_status(200)
    end

    it 'assigns the admin_users' do
      get :index

      expect(assigns(:admin_users)).to include(admin_user)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new

      expect(response).to have_http_status(200)
    end

    it 'assigns the admin_user' do
      get :new

      expect(assigns(:admin_user)).to be_a(AdminUser)
      expect(assigns(:admin_user)).to be_new_record
    end
  end

  describe 'GET show' do
    it 'returns http success' do
      get :show, params: { id: admin_user.id }

      expect(response).to have_http_status(200)
    end

    it 'assigns the admin_user' do
      get :show, params: { id: admin_user.id }

      expect(assigns(:admin_user)).to eq(admin_user)
    end
  end

  describe 'POST create' do
    context 'with valid params'  do
      let(:admin_user_params) { attributes_for :admin_user }

      it 'redirects to show' do
        post :create, params: { admin_user: admin_user_params }

        expect(response).to redirect_to(admin_admin_user_path(assigns(:admin_user)))
      end

      it 'assigns the admin_user' do
        post :create, params: { admin_user: admin_user_params }

        expect(assigns(:admin_user)).to be_a(AdminUser)
        expect(assigns(:admin_user)).to be_persisted
        expect(assigns(:admin_user).email).to eq(admin_user_params[:email])
      end
    end

    context 'with invalid params'  do
      let(:admin_user_params) { attributes_for :admin_user, email: nil }

      it 'returns http success' do
        post :create, params: { admin_user: admin_user_params }

        expect(response).to have_http_status(200)
      end

      it 'assigns the admin_user with error' do
        post :create, params: { admin_user: admin_user_params }

        expect(assigns(:admin_user)).to be_a(AdminUser)
        expect(assigns(:admin_user)).not_to be_persisted
        expect(assigns(:admin_user).errors.messages).to eq(email: ["can't be blank"])
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params'  do
      let(:admin_user) { create :admin_user }

      it 'redirects to show' do
        put :update,
          params: {
            id: admin_user.id,
            admin_user: {
              password: '654321',
              password_confirmation: '654321'
            }
          }

        expect(response).to redirect_to(admin_admin_user_path(admin_user))
      end
    end

    context 'with invalid params'  do
      let(:admin_user) { create :admin_user }

      it 'redirects to show' do
        put :update, params: { id: admin_user.id, admin_user: { email: nil } }

        expect(response).to have_http_status(200)
      end

      it 'assigns the admin_user with error' do
        put :update, params: { id: admin_user.id, admin_user: { email: nil } }

        expect(assigns(:admin_user).errors.messages)
          .to eq(email: ["can't be blank"])
      end
    end
  end

  describe 'POST destroy' do
    let(:admin_user) { create :admin_user }

    it 'redirects to index' do
      post :destroy, params: { id: admin_user.id }

      expect(response).to redirect_to(admin_admin_users_path)
    end

    it 'deletes the admin_user' do
      post :destroy, params: { id: admin_user.id }

      expect { admin_user.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
