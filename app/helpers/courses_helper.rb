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
  
  def review_course(course)
    if user_signed_in?
        user_sub = current_user.subscriptions.where(course_id: course.id)
      if user_sub.present?#this is now a subscription
        #user_sub.where(rating: [0,nil, ""], review: [0,nil, ""]).present?
        if  user_sub.pending_review.present?#scope in subsription
          link_to 'Pls, Add a Review', edit_subscription_path(user_sub.first), class: 'btn btn-primary'
        else
          link_to "Thanks for the review!", subscription_path(user_sub.first)
        end
      end
        
      
    end
  end
  
end
