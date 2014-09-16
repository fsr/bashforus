# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.where(email: 'bashforus@example.com').first_or_create(password:'p4ssw0rd!',password_confirmation:'p4ssw0rd!')
admin.confirm! unless admin.confirmed?
admin.add_role :admin
puts <<END
Created administrator

eMail addess: bashforus@example.com
password:     p4ssw0rd!

Please change the password really soon!
END