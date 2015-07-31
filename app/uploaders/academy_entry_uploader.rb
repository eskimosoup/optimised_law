class AcademyEntryUploader < Chronicler::ImageUploader

  version :small do
    process :resize_to_fit => [128, 154]
  end
  
  version :large do
    process :resize_to_fit => [245, 274]
  end
end
