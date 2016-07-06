require 'spec_helper'

describe Api::UsersController do
  describe '#show' do
    context 'when no token in request' do

    end

    context 'when no user session for that token' do

    end

    context 'when token is valid' do

    end
  end

  describe '#managed_users' do
    context 'when current user is customer' do

    end

    context 'when current user is admin' do

    end
  end

  describe '#create' do
    context 'no email is request' do

    end

    context 'params is valid' do

    end
  end

  describe '#destroy_user' do
    context 'no user_id is request' do

    end

    context 'params is valid' do

    end
  end
end