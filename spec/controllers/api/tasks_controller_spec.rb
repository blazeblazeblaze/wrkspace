require 'rails_helper'

describe Api::TasksController do
  login_user

  RSpec.shared_examples 'json api' do
    it 'responds with JSON' do
      expect(response.content_type).to eq('application/json')
    end
  end

  describe 'GET index' do
    include_examples 'json api'
    let!(:task) { create(:task, user: subject.current_user) }

    before do
      allow(TaskSearch).to receive(:new).and_call_original
      get :index
    end

    it 'returns 200' do
      expect(response).to be_successful
    end

    it 'returns collection of tasks' do
      expect(response.parsed_body).to eq [task].to_json
    end

    it 'uses TaskSearch to retrieve records' do
      expect(TaskSearch).to have_received(:new)
    end
  end

  describe 'POST create' do
    context 'when successfully created' do
      it_behaves_like 'json api'

      let(:task) do
        {
          user_id: subject.current_user.id,
          title: ''
        }
      end
      before { post :create, params: {} }

      it 'returns 201' do
        expect(response.status).to eq 201
      end

      it 'returns newly created task that belongs to current_user' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['user_id']).to eq subject.current_user.id
      end
    end

    context 'when unsuccesfully created' do
      it_behaves_like 'json api'

      before do
        allow_any_instance_of(Task).to receive(:save) { false }
        post :create, params: {}
      end

      it 'returns 422' do
        expect(response.status).to eq 422
      end

      it 'returns json with errors' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body).to have_key('errors')
      end
    end
  end

  describe 'PUT update' do
    let(:task) { create(:task, user: subject.current_user) }
    let(:task_params) do
      {
        id: task.id,
        task: {
          title: 'new_title'
        }
      }
    end

    context 'when successfully updated' do
      it_behaves_like 'json api'

      before { put :update, params: task_params }

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns newly updated task' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['title']).to eq task_params[:task][:title]
      end
    end

    context 'when unsuccesfully updated' do
      it_behaves_like 'json api'

      before do
        allow_any_instance_of(Task).to receive(:update) { false }
        put :update, params: task_params
      end

      it 'returns 422' do
        expect(response.status).to eq 422
      end

      it 'returns json with errors' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body).to have_key('errors')
      end
    end
  end

  describe 'DELETE destroy' do
    let(:task) { create(:task, user: subject.current_user) }
    let(:task_params) do
      {
        id: task.id
      }
    end

    context 'when successfully destroyed' do
      it_behaves_like 'json api'

      before { delete :destroy, params: task_params }

      it 'returns 200' do
        expect(response.status).to eq 200
      end

      it 'returns destroyed task' do
        expect(response.parsed_body).to eq task.to_json
      end
    end

    context 'when unsuccesfully destroyed' do
      it_behaves_like 'json api'

      before do
        allow_any_instance_of(Task).to receive(:destroy) { false }
        delete :destroy, params: task_params
      end

      it 'returns 422' do
        expect(response.status).to eq 422
      end

      it 'returns json with errors' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body).to have_key('errors')
      end
    end
  end
end
