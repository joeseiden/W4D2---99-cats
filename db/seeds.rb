# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

c1 = Cat.create!(birth_date: '2014/3/14', name: 'Tina', color: 'grey', sex: 'F', description: 'RIP Tina')
c2 = Cat.create!(birth_date: '2013/4/14', name: 'Beyonce', color: 'black', sex: 'F', description: 'Queen B')
c3 = Cat.create!(birth_date: '2012/5/14', name: 'Jay Z', color: 'white', sex: 'M', description: 'Ma Man')
c4 = Cat.create!(birth_date: '2011/6/14', name: 'MJ', color: 'calico', sex: 'M', description: 'RIP MJ')
