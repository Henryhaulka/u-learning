u = User.find_by!(email: 'onuhenry24@gmail.com')
30.times do 
    Course.create!([{ 
     title: Faker::Educator.course_name,
     description:  Faker::TvShows::GameOfThrones.quote,
     user_id: u.id
    }])
end

