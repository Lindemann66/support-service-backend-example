Feature: User
  A customer
  Should authenticate successfully

  Scenario: Customer authenticate
    Given I visit login page
    When I fill email and password
    And I click sign in
    Then page should redirected to "dashboard"


# spent too much time on strange error
# for some unknown reason now i get this respone on my machine

# other requests completed with the same result

#RESPONSE [application/json]: {"user":{"id":1,"email":"customer@email.com","role":1,"password":"5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8","created_at":"2016-07-05T05:31:48.000Z","updated_at":"2016-07-05T05:31:48.000Z"},"token":"44214ea95269678c690f2e54f35ef3b2","status":200}
#[2016-07-05 09:31:48] ERROR Errno::ECONNRESET: Connection reset by peer @ io_fillbuf - fd:15
#  /Users/alexeyivanov/.rbenv/versions/2.2.3/lib/ruby/2.2.0/webrick/httpserver.rb:80:in `eof?'
#  /Users/alexeyivanov/.rbenv/versions/2.2.3/lib/ruby/2.2.0/webrick/httpserver.rb:80:in `run'
#  /Users/alexeyivanov/.rbenv/versions/2.2.3/lib/ruby/2.2.0/webrick/server.rb:294:in `block in start_thread'


#-------


#~/work/support_app/support_backend » RAILS_ENV=test bundle exec cucumber
#Using the default profile...
#Feature: User
#  A customer
#  Should authenticate successfully
#  Scenario: Customer authenticate              # features/user.feature:5
#    Given I visit login page                   # features/step_definitions/user.rb:1
#    When I fill email and password             # features/step_definitions/user.rb:6
#    And I click sign in                        # features/step_definitions/user.rb:11
#    Then page should redirected to "dashboard" # features/step_definitions/user.rb:15
#      expected: "dashboard"
#           got: "/" (using ==) (RSpec::Expectations::ExpectationNotMetError)
#      ./features/step_definitions/user.rb:16:in `/^page should redirected to "(.*?)"$/'
#      ./features/support/env.rb:49:in `block in <top (required)>'
#      /Users/alexeyivanov/.rbenv/versions/2.2.3/bin/bundle:23:in `load'
#      /Users/alexeyivanov/.rbenv/versions/2.2.3/bin/bundle:23:in `<main>'
#      features/user.feature:9:in `Then page should redirected to "dashboard"'


#~/work/support_app/support_backend » rails server --environment test

#=> Booting WEBrick
#=> Rails 4.2.6 application starting in test on http://localhost:3000
#=> Run `rails server -h` for more startup options
#=> Ctrl-C to shutdown server
#[2016-07-05 10:01:17] INFO  WEBrick 1.3.1
#[2016-07-05 10:01:17] INFO  ruby 2.2.3 (2015-08-18) [x86_64-darwin15]
#[2016-07-05 10:01:17] INFO  WEBrick::HTTPServer#start: pid=10542 port=3000
#RESPONSE [application/json]: {"user":null}
#RESPONSE [application/json]: {"user":{"id":1,"email":"customer@email.com","role":1,"password":"5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8","created_at":"2016-07-05T06:01:22.000Z","updated_at":"2016-07-05T06:01:22.000Z"},"token":"3f69f3c21a076bc36ba3006803bc26e5","status":200}
#[2016-07-05 10:01:22] ERROR Errno::ECONNRESET: Connection reset by peer @ io_fillbuf - fd:15
#  /Users/alexeyivanov/.rbenv/versions/2.2.3/lib/ruby/2.2.0/webrick/httpserver.rb:80:in `eof?'
#  /Users/alexeyivanov/.rbenv/versions/2.2.3/lib/ruby/2.2.0/webrick/httpserver.rb:80:in `run'
#  /Users/alexeyivanov/.rbenv/versions/2.2.3/lib/ruby/2.2.0/webrick/server.rb:294:in `block in start_thread'