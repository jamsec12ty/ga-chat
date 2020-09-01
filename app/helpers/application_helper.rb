module ApplicationHelper

  # CHECK USER PROFILE IMAGE ---------------------------------------
  
  # Used on posts#index and posts#show pages
  def check_user_image_small(user)
    if user.image.present?
      cl_image_tag user.image, class: "profile_image_small"
    else
      image_tag "avatar.png", class: "profile_image_small"
    end
  end

  # Used on posts#index and posts#show pages
  def check_user_image_middle(user)
    if user.image.present?
      cl_image_tag user.image, class: "profile_image_middle"
    else
      image_tag "avatar.png", class: "profile_image_middle"
    end
  end

  # Used on users#show page
  def check_user_image_large(user)
    if user.image.present?
      cl_image_tag user.image, class: "profile_image_large"
    else
      image_tag "avatar.png"
    end
  end

end
