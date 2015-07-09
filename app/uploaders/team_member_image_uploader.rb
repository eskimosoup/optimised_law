class TeamMemberImageUploader < Chronicler::ImageUploader

  version :small do
    process :resize_to_fit => [1000, 80]
  end
  
  version :large do
    process :resize_to_fit => [150, 150]
  end

end
