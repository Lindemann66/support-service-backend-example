Given(/^I visit login page$/) do
  visit "/"
  @user = FactoryGirl.create(:user, email: "customer@email.com")
end

When(/^I fill email and password$/) do
  fill_in('email', :with => @user.email)
  fill_in('password', :with => 'password')
end

And(/^I click sign in$/) do
  click_button("Sign in")
end

Then(/^page should redirected to "(.*?)"$/) do |page|
  current_path.should == page
end
