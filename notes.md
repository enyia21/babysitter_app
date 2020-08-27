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
#### Babysitter 
- has_many :appointments
- has_many :children, through: :appointments
- has_many :reviews, through: :appointments
- :name
- :username
- :phone_number
- :email
- :password_digest
- :hourly_rate


#### Appointment
- has_many :appointment_childern
- has_many :children, through: :appointment_children 
- has_one :review
- :date
- :start_time
- :end_time
- :number_of_children?
- :appointment_cost
- :completed?
- :babysitter_id

#### Appointment_Children
- belongs_to :appointments
- belongs_to :children
- appointment_id
- child_id

#### Child
- has_many :appointment_children
- has_many :appointments, through: :appointment_children
- has_many :babysitters, through: :appointments 
- belongs_to :parent 
- :name
- :age
- :parent_id


#### Parent
- has_many :children
- has_many :reviews
- has_many :appointments, through: :children
- has_many :babysitters, through: :appointments
- :name
- :username
- :email
- :password_digest


#### Review
- belongs_to :parent 
- belongs_to :appointment 
- rating (scale of: 1-5)
- comments
- parent_id
- appointment_id

#### Admin
- :name
- :username
- :password_digest
- :email

## User Story
The babysitting app will Parents and babybsitters to schedule and track babysitting appointment through the app.  Each babysitter will be able to sign up, post a suggetst rate per child and provide information to the app that is relevant to the parents.  

Each parent will be able to sign up and signup their children, make babysitting appointments, and review those appointments through the app.  There children will be registered and they will be able to track there appointmens and their babysitters for those appointments 

Each child will be watched by a babysitter for the appointed time.  

Each admin will be able to access accounts through the website and review site wide statistics and overall user outcomes.  

## Action Items

1.  Create rails app utilizing:  
    ``` rails new babysitter_app ```
2.  Create a new repository on git hub
3.  Add a git repository 
``` git remote add origin git@github.com:enyia21/babysitter_app.git```
``` git branch -M master ```
``` git push -u origin master ```
4.  Generate Resources (Models)
    1. Admin
    2. Parent
    3. Child
    4. Babysitter 
    5. Appointment
    6. Appointment_children 
    7. Review 
5.  Gem files to install
    1. Bcypt to allow for has_secure_password



