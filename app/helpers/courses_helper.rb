module CoursesHelper
  def subscribe_button(course)
    if user_signed_in?
      if current_user == course.user
          link_to 'You created this Course, View analytics', course_path(course),class: 'text-decoration-none text-primary'
      elsif course.subscriptions.where(user_id: current_user).present?
          "<i class='fa fa-spinner text-primary'></i>".html_safe + ' ' +
          number_to_percentage(course.progress_rate(current_user), precision: 0)  + 
          "<div class = 'text-success'>You already subscribed to this course, Keep learning</div>".html_safe
      elsif course.price.zero?
          link_to 'Free', new_course_subscription_path(course), class: 'btn btn-success'
      elsif !course.price.zero?
          link_to number_to_currency(course.price), new_course_subscription_path(course), class: 'btn btn-success'
      end
    else
        link_to "Check Price", new_course_subscription_path(course), class: 'btn btn-success'
    end
      
  end
  
  def review_course(course)
    if user_signed_in?
        user_sub = current_user.subscriptions.where(course_id: course.id)
      if user_sub.present?#this is now a subscription
        #user_sub.where(rating: [0,nil, ""], review: [0,nil, ""]).present?
        if  user_sub.pending_review.present?#scope in subsription
          link_to  edit_subscription_path(user_sub.first), class: 'btn btn-primary' do
            "<i class='fa fa-star text-warning'></i>".html_safe + '' +
            "<i class='fa fa-question text-warning'></i>".html_safe + '' +
            ' Add a Review'
          end
        else
          link_to subscription_path(user_sub.first), class: 'btn btn-success' do
            "<i class='fa fa-star text-warning'></i>".html_safe + '' +
            "<i class='fa fa-check text-white'></i>".html_safe + '' + ' ' +
               "Thanks for the review!"
          end
        end
      end
    end
  end

  def certificate_button(course)
    user_sub = current_user.subscriptions.where(course_id: course.id)
    if  user_sub.any?
      if course.progress_rate(current_user) == 100
        link_to certificate_subscription_path(user_sub.first, format: :pdf), class: 'btn btn-success' do
           "<i class='fa fa-file-pdf'></i>".html_safe + ' ' +
           "Certificate of Completion"
        end
      else
        "<span class = 'nocomplete'>Complete the Course to view your Certificate</span>".html_safe
        
      end
    end
  end
end
