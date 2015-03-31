class TextUtils
  def self.truncate(text, length = 255, truncate_string = "...")
    if text
      l = length - truncate_string.chars.length
      chars = text.chars
      (chars.length > length ? chars[0...l].join + truncate_string : text).to_s
    end
  end
end
