password = Encryptor.encrypt('password')

#customers
User.create(email: "customer1@email.com", password: password)
User.create(email: "customer2@email.com", password: password)

#support
User.create(email: "support1@email.com", password: password, role: User::SUPPORT_ROLE_ID)
User.create(email: "support2@email.com", password: password, role: User::SUPPORT_ROLE_ID)

#admin
User.create(email: "admin@email.com", password: password, role: User::ADMIN_ROLE_ID)

#requests
User.first.requests.create(text: "Request 1")
User.first.requests.create(text: "Request 2")#, status: Request::FIXED_STATUS)
User.first.requests.create(text: "Request 3")#, status: Request::DENIED_STATUS)
User.second.requests.create(text: "Request 4")#, status: Request::FIXED_STATUS)