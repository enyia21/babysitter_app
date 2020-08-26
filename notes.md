# Primary Questions
1.  Why make this app?
2.  How should this app help?
3.  What will this app do?

## Relationships
[x] 1. Babysitter has_many appointments, each appointment belongs_to a babysitter (has_many -- belongs_to)
[x] 2. Each appointment has_many children, each child has_many appointments (many-to-many) 
    * Note this requires a join table 
[x] 3. Each Parent has_many children, each child belongs_to a parent (has_many -- belongs_to)
[x] 4. Each review belongs_to a parent each parent has_many reviews (has_many -- belongs_to)
[x] 5. Each review belongs_to an appointment, an appointment, appointment has-on review (has_one -- belongs_to)
[x] 6. Each babysitter -has_many- reviews -through- appointments (has_many through)
[x] 7. Each babysitter -has_many- children -through- appointments (has_many through)
[x] 8. Each child -has_many- babysitters -through- appointments (has_many through)
[x] 9. Each parent -has_many- appointments through children (has_many through)
[x] 10. Each parent -has_many- babysitters through appointments (has_many through)

## Models
Babysitter 
- has_many :appointments
- has_many :children, through: :appointments
- has_many :reviews, through: :appointments

- :name
- :username
- :phone_number
- :email
- :password_digest
- :availablility?


Appointment
- has_many :appointment_childern
- has_many :children, through: :appointment_children 
- has_one :review
- :date
- :start_time
- :end_time
- :number_of_children?
- :appointment_cost

Appointment_Children
- belongs_to :appointments
- belongs_to :children

Child
- has_many :appointment_children
- has_many :appointments, through: :appointment_children
- has_many :babysitters, through: :appointments 
- belongs_to :parent 


Parent
- has_many :children
- has_many :reviews
- has_many :appointments, through: :children
- has_many :babysitters, through: :appointments

Review
- belongs_to :parent 
- belongs_to :appointment 


- has_many :reviews, through: :appointments 
    *** Properties ***
- :name
- :email
- :username
- :password_digest
- :rate per/hr * # of children
- :experience


- belongs_to :babysitter
- :date 
- :time
- :