# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
max = User.create(email: 'max@gmail.com', premium: true)
bill = User.create(email: 'bill@gmail.com')

ShortenedUrl.delete_all
a = ShortenedUrl.create_for_user_and_long_url!(max.id, "google.com")
b = ShortenedUrl.create_for_user_and_long_url!(max.id, "facebook.com")
c = ShortenedUrl.create_for_user_and_long_url!(bill.id, "twitter.com")
d = ShortenedUrl.create_for_user_and_long_url!(bill.id, "imgur.com")

Visit.delete_all
Visit.create(user_id: max.id, url_id: c.id)
Visit.create(user_id: max.id, url_id: d.id)
Visit.create(user_id: bill.id, url_id: a.id)
Visit.create(user_id: bill.id, url_id: b.id)

TagTopic.delete_all
test1 = TagTopic.create(tag: "test1")
test2 = TagTopic.create(tag: "test2")

Tagging.delete_all
Tagging.create(url_id: a.id, tag_id: test1.id)
Tagging.create(url_id: a.id, tag_id: test2.id)
Tagging.create(url_id: b.id, tag_id: test1.id)
Tagging.create(url_id: c.id, tag_id: test2.id)
