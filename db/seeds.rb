# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

facebook = Account.create(name: 'Facebook')

20.times do
  facebook.contacts.create!(contactable: Organization.new(name: Faker::Company.name))
end

20.times do
  facebook.contacts.create!(contactable: Person.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    title: %w(Mr Mrs Miss Ms Sir Dr Lady Lord).sample,
    job_title: Faker::Job.position
  ))
end

facebook.contacts.people.each do |person|
  person.contactable.update(organization: Organization.all.sample)
end


Contact.all.each do |contact|
  7.times do
    contact.cases.create!(
      name: Faker::Company.bs,
      description: Faker::Company.bs,
      closed_at: [Faker::Date.backward(30), nil].sample,
      assigned_user: Person.all.sample
    )
  end
end
