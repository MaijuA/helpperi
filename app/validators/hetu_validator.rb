class HetuValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !hetu_valid? value
      record.errors[attribute] << (options[:messages] || "on virheellinen")
    elsif hetu_too_young? value
      record.errors[attribute] << (options[:messages] || " - palveluun voivat rekisteröityä vain yli 15 vuotiaat")
    end
  end

  private

  def hetu_valid? hetu
    return false if hetu == nil || hetu.length != 11

    date = hetu[0..1].to_i
    month = hetu[2..3].to_i
    year = hetu[4..5].to_i
    century = hetu[6]

    if century == "+"
      year += 1800
    elsif century == "-"
      year += 1900
    elsif century == "A"
      year += 2000
    else
      return false
    end

    begin
      Date.new(year, month, date)
    rescue ArgumentError
      return false
    end

    nnn = hetu[7..9].to_i

    return false if nnn < 2 || nnn > 899

    jaannos = (hetu[0..5] + hetu[7..9]).to_i % 31
    tarkistus = hetu[10].to_s.upcase
    tarkistus_taulukko = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "H", "J", "K", "L", "M", "N", "P", "R", "S", "T", "U", "V", "W", "X", "U"]

    tarkistus == tarkistus_taulukko[jaannos]
  end

  def hetu_too_young? hetu
    date = hetu[0..1].to_i
    month = hetu[2..3].to_i
    year = hetu[4..5].to_i
    century = hetu[6]

    if century == "+"
      year += 1800
    elsif century == "-"
      year += 1900
    elsif century == "A"
      year += 2000
    end

    begin
      return Date.new(year, month, date) + 15.years >= Date.today
    rescue ArgumentError
      # false
    end
  end
end