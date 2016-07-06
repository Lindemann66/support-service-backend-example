require 'spec_helper'

# no time for tests (
describe Api::RequestsController do

  let(:user1) { FactoryGirl.create(:user) }
  let(:request1) { FactoryGirl.create(:request, user: user1) }
  let(:request2) { FactoryGirl.create(:request, user: user1) }

  let(:user2) { FactoryGirl.create(:user, :support) }
  let(:request3) { FactoryGirl.create(:request, user: @user) }

  describe '#index' do
    before do
      described_class.any_instance.stub(:current_api_user).and_return(user2)
    end

    context 'when current user is support' do
      subject { get :index }
      #it_behaves_like :api_request
      #its(:body) { should have_content request1.text }
      #its(:body) { should have_content request3.text }
    end
  end

  describe '#create' do
    context 'when no request_text in request' do

    end

    context 'when current user is support' do

    end

    context 'when current user is customer' do

    end
  end

  describe '#update_request' do
    context 'when current user is customer' do

    end

    context 'when current user is support' do

    end
  end

  describe '#destroy_request' do
    context 'when current user is support' do

    end

    context 'when current user is admin' do

    end
  end

  describe '#search' do
    context 'when current user is customer' do

    end

    context 'when current user is support' do

    end
  end

  describe '#as_pdf' do
    context 'when current user is customer' do

    end

    context 'when current user is support' do

    end
  end
end
