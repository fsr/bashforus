# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin_email = 'admin@local.host'
admin_password = 'p4ssw0rd!'

admin = User.where(email: admin_email ).first_or_create(password:admin_password,password_confirmation:admin_password)

admin.skip_confirmation! unless admin.confirmed?

admin.add_role :admin

admin.save!

puts <<-END
Created administrator

eMail addess: #{admin_email}
password:     #{admin_password}

Please change the password really soon!

You should adapt config/config.yml to your needs. Especially domain_name!

If you arn't using pow (https://pow.cx) you may use the domain 'lvh.me' :-)
END