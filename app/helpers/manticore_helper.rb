module ManticoreHelper

  def hide_flash
    @hide_flash = true
  end
  
  def hide_flash?
    @hide_flash
  end

  def meta_description(value)
    @meta_description = value
  end
  
  def meta_tags(value)
    @meta_tags = value
  end
  
  def shorten(text, length=150)
    text = strip_tags(text)
    if text.length > length
      text[0..length].split[0..-2].join(' ') + '...'
    else
      text
    end
  end
  
  def title(value)
    content_for(:title) { h(value.to_s) }
    value
  end
  
end
