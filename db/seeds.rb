require 'faker'

facebook = Account.create(name: 'Facebook')

facebook.users.create!(admin: true, email: 'admin@facebook.com', password: 'password', password_confirmation: 'password')

facebook.circles.create!(title: 'Competitors')
facebook.circles.create!(title: 'Suppliers')

facebook.users.each do |user|
  10.times do
    user.tasks.create!(
      title: Faker::Company.bs,
      completed_at: [Faker::Date.backward(30), nil, nil].sample
    )
  end
end

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
      assigned_user: User.all.sample
    )
  end
end
