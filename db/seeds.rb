# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create([email: 'roblane09@gmail.com', password: 'password'])
Setting.create([
    { name: 'title', value: 'A Simple Blog' },
    { name: 'subtitle', value: 'By Rob Lane' },
    { name: 'logo', value: '', field_type: 'image' }])