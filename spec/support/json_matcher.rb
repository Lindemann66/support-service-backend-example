RSpec::Matchers.define :be_valid_json do
  match do |actual|
    JSON.parse(actual)
  end
end