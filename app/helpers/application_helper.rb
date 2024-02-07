module ApplicationHelper
  def input_classes
    ''
  end

  def flash_classes(key)
    case key
    when 'notice'
      'bg-blue-100 text-blue-600'
    when 'error'
      'bg-red-100 text-red-700'
    else
      'bg-gray-100 text-gray-700'
    end
  end
end
