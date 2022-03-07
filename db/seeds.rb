PublicActivity.enabled = false
u = User.find_by!(email: 'onuhenry24@gmail.com')
30.times do 
    Course.create!([{ 
     title: Faker::Educator.course_name,
     description:  Faker::TvShows::GameOfThrones.quote,
     user_id: u.id,
     short_description: Faker::Quote.famous_last_words,
     level: 'Beginner',
     language: Faker::ProgrammingLanguage.name,
     price: Faker::Number.within(range: 10..1000)
    }])
end

PublicActivity.enabled = true

