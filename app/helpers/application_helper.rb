module ApplicationHelper

  # Retourner un titre basé sur la page.
  def title
    title_base = "MyMoviez"
    if @title.nil?
      title_base
    else
      "#{title_base} | #{@title}"
    end
  end

  def version
    "alpha 0.0.1"
  end

end
