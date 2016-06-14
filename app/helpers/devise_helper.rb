module DeviseHelper
  def devise_error_messages!
    return html_errors unless params[:finishing].nil?
    return "" if resource.errors.empty?
    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                    count: resource.errors.count,
                    resource: resource.class.model_name.human.downcase)
    html = <<-HTML
       <div id="error_explanation">
         <h2>#{sentence}</h2>
         <ul>#{messages}</ul>
       </div>
    HTML
    html.html_safe
  end

  def html_errors
    html = <<-HTML
       <div id="error_explanation">
         <h2>Sinun täytyy viimeistellä rekisteröitymisesi, jotta voit:</h2>
          <ul>
            <li>luoda uusia ilmoituksia</li>
            <li>lähettää viestejä muille käyttäjille</li>
            <li>tarkastella muiden käyttäjien profiileja</li>
          <ul>
       </div>
    HTML
    html.html_safe
  end
end