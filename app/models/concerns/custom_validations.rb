module CustomValidations
  extend ActiveSupport::Concern

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
    rescue StandardError
      return false
    end

    nnn = hetu[7..9].to_i

    return false if nnn < 2 || nnn > 899

    jaannos = (hetu[0..5] + hetu[7..9]).to_i % 31
    tarkistus = hetu[10]
    tarkistus_taulukko = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "H", "J", "K", "L", "M", "N", "P", "R", "S", "T", "U", "V", "W", "X", "U"]

    if tarkistus == tarkistus_taulukko[jaannos]
      return true
    else
      return false
    end
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
    return false
  end
end