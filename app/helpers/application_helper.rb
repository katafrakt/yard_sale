module ApplicationHelper
  def availability_classes(offer)
    case offer.state
    when :available then "text-teal-600 bg-teal-200"
    when :reserved then "text-yellow-600 bg-yellow-200"
    end
  end

  def availability_label(offer)
    case offer.state
    when :available then "available"
    when :reserved then "reserved"
    end
  end
end
