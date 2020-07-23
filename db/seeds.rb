admin = Role.create(name: :admin)
Role.create(name: :user)
Role.create(name: :author)
User.create(email: 'admin@admin.ru', password: "111111", password_confirmation: "111111", roles: [admin])