module ApplicationHelper
  def availability_classes(offer)
    case offer.state
    when :available then "text-teal-600 bg-teal-200"
    end
  end

  def availability_label(offer)
    case offer.state
    when :available then "available"
    end
  end
end
