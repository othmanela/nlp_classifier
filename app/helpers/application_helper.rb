module ApplicationHelper
  def flash_class(level)
    case level
      when 'notice' then "alert alert-info alert-dismissible"
      when 'success' then "alert alert-success alert-dismissible"
      when 'warning' then "alert alert-warning alert-dismissible"
      when 'danger' then "alert alert-danger alert-dismissible"
    end
  end
end
