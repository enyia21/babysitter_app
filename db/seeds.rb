# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

5.times do 
    firstName = Faker::Name.first_name
    lastName = Faker::Name.unique.last_name
    username_specifier = lastName + rand(9).to_s + rand(9).to_s
    userName = Faker::Internet.username(specifier: username_specifier)
    Admin.create(
        first_name: firstName,
        last_name: lastName,
        username: userName,
        email: Faker::Internet.safe_email(name: lastName),
        password: 'password'
    )
end
15.times do 
    # create babysitters
    sitter_firstName = Faker::Name.first_name
    sitter_lastName = Faker::Name.unique.last_name
    sitter_username_specifier = sitter_lastName + rand(9).to_s + rand(9).to_s
    sitter_userName = Faker::Internet.username(specifier: sitter_username_specifier)
    sitter = Babysitter.create(
        first_name: sitter_firstName,
        last_name: sitter_lastName,
        username: sitter_userName,
        email: Faker::Internet.safe_email(name: sitter_lastName),
        password: 'password',
        phone_number: Faker::PhoneNumber.cell_phone
    )
    # create parent 
    parent_firstName = Faker::Name.first_name
    parent_lastName = Faker::Name.unique.last_name
    parent_username_specifier = parent_lastName + rand(9).to_s + rand(9).to_s
    parent_userName = Faker::Internet.username(specifier: parent_username_specifier)
    parent = Parent.create(
        first_name: parent_firstName,
        last_name: parent_lastName,
        username: parent_userName,
        email: Faker::Internet.safe_email(name: parent_lastName),
        password: 'password',
        phone_number: Faker::PhoneNumber.cell_phone
    )
    #create child(ren)
    number_of_children = rand(1..4)
    number_of_children.times do 
        child_firstName = Faker::Name.first_name
        child = Child.create(
            first_name: child_firstName,
            last_name: parent.last_name,
            age: rand(5..15),
            parent_id: parent.id
        )

    end
    #create appointments 
    number_of_appointments = rand(1..4)
    number_of_appointments.times do
        date = Faker::Date.backward(days: 14)
        start = DateTime.new(date.year, date.month, date.day, 15, 0, 0)
        finish = Faker::Time.between(from: start, to: date.tomorrow)
        hours_worked = ((finish - start) / 3600).round(2)
        calculated_appointment_cost = (number_of_children * (hours_worked) * 7).round(2)
        new_appointment = Appointment.create(
            date: date,
            start_time: start,
            end_time: finish,
            number_of_children: parent.children.count,
            completed: true,
            babysitter_id: sitter.id,
            appointment_cost: calculated_appointment_cost
        )
        # add children to the appointment
        parent.children.each do |child|
            child.appointments << new_appointment
            if !new_appointment.review.present? 
                rating = rand(1...6)
                comment = Faker::Lorem.paragraph(sentence_count: rand(4..7))
                new_review = Review.create(rating: rating, comment: comment, parent_id: parent.id, appointment_id: new_appointment.id)
            end
        end
        
    end
end
