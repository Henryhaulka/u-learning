module ApplicationHelper
   include Pagy::Frontend
  def creative_icons(key)
    case key
        when 'create'
           "<i class='fa fa-plus text-success'></i>".html_safe
        when 'update'
         "<i class='fa fa-pen text-primary'></i>".html_safe
        when 'destroy'
         "<i class='fa fa-trash text-danger'></i>".html_safe     
    end
  end
  
  def model_type(model)
    case model
        when 'Course'
           "<i class='fa fa-graduation-cap '></i>".html_safe
        when 'Lesson'
         "<i class='fa fa-tasks '></i>".html_safe    
    end
  end 
end
