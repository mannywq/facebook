module ApplicationHelper
  def input_classes
    'shadow w-full text-gray-800 bg-slate-50 appearance-none focus:outline-none focus:border-blue-100 rounded border-2 border-gray-200'
  end

  def btn_classes
    'w-full cursor-pointer bg-blue-600 text-white font-medium p-2 px-4 rounded-md'
  end

  def text_area_classes
    'shadow mt-3 w-full resize-none text-gray-800 appearance-none focus:outline-none focus:border-blue-100 rounded border-2 border-gray-200 w-80'
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
