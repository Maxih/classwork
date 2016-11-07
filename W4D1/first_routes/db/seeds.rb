# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
User.create(username: "maxih")
User.create(username: "shadypete")

Contact.destroy_all
Contact.create(email: "max@gmail.com", name: "Max", user_id: User.find_by(username: "maxih").id)
Contact.create(email: "pete@gmail.com", name: "Pete", user_id: User.find_by(username: "shadypete").id)

Comment.destroy_all
Comment.create(body: "This is a test", commentable_id: User.find_by(username: "maxih").id, commentable_type: "User")
Comment.create(body: "Also a test", commentable_id: User.find_by(username: "maxih").id, commentable_type: "User")
Comment.create(body: "Test Contact comment", commentable_id: Contact.find_by(name: "Max").id, commentable_type: "Contact")
