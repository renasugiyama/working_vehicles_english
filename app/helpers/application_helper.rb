module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice
      "bg-blue-100 border border-blue-400 text-blue-700"
    when :alert
      "bg-red-100 border border-red-400 text-red-700"
    else
      "bg-gray-100 border border-gray-400 text-gray-700"
    end
  end

  def flash_text_color(type)
    case type.to_sym
    when :notice
      "text-blue-700"
    when :alert
      "text-red-700"
    else
      "text-gray-700"
    end
  end

  def current_player
    @current_player ||= current_user.players.find_by(id: session[:current_player_id])
  end
end
