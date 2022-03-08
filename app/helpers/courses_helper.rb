module CoursesHelper
  def subscribe_button(course)
    if user_signed_in?
      if current_user == course.user
          link_to 'You created this Course, View analytics', course_path(course),class: 'text-decoration-none'
      elsif course.subscriptions.where(user_id: current_user).present?
          link_to 'You already subscribed to this course, Keep learning', course_path(course), class: 'text-decoration-none'
      elsif course.price.zero?
          link_to 'Free', new_course_subscription_path(course), class: 'btn btn-success'
      elsif !course.price.zero?
          link_to number_to_currency(course.price), new_course_subscription_path(course), class: 'btn btn-success'
      end
    else
        link_to "Check Price", courses_path, class: 'btn btn-success'
    end
      
  end
  
end
