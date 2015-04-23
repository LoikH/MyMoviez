module ApplicationHelper

  def title_base
    "MyMoviez"
  end

  # Retourner un titre basé sur la page.
  def title
    if @title.nil?
      title_base
    else
      "#{title_base} | #{@title}"
    end
  end

  def logo
    image_tag("logo1.png", :alt => "MyMoviez")
  end

  def version
    "alpha 0.0.1"
  end

end
