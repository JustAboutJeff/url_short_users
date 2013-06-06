5.times do 
      @user = User.create({ name: Faker::Name.name,
                           email: Faker::Internet.email,
                        password: 'password'
      })
      5.times do Url.create({ long_url: 'http://' + Faker::Internet.domain_name,
                               user_id: @user.id
      })
      end
end

