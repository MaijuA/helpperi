class DateInFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil?
      if value < Date.today
        record.errors[attribute] << (options[:message] || "on oltava tulevaisuudessa")
      elsif value > Date.today + 6.months
        record.errors[attribute] << (options[:message] || "saa olla korkeintaan kuuden kuukauden päässä")
      end
    end
  end
end