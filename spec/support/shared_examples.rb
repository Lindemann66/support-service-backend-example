shared_examples_for :api_request do |args|
  its(:body) { should have_content args[:response] }
  it { should be_success }
  its(:body) { should be_valid_json }
end