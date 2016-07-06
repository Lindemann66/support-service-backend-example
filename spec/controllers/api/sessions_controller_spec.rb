require 'spec_helper'

describe Api::SessionsController do
  let(:user) { FactoryGirl.create(:user) }

  describe '#create' do
    context 'when no email in request' do

    end

    context 'when passwords doesn\'t match' do

    end

    context 'when params is valid' do

    end
  end

  describe '#destroy_session' do
    context 'when no token in request' do

    end

    context 'when session is not found' do

    end

    context 'when token and session exists and valid' do

    end
  end

end
