User.create!(email: 'onuhenry24@gmail.com', password: '123456')
30.times do 
    Course.create!([{ 
     title: Faker::Educator.course_name,
     description:  Faker::TvShows::GameOfThrones.quote,
     user_id: 1
    }])
end

