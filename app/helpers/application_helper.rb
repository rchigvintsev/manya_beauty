module ApplicationHelper
  def warn
    flash[:warn]
  end

  def smart_truncate(s, options = {})
    options = { words: 12 }.merge(options)

    if options[:sentences]
      return s.split(/(?<=[.?!])\s+/).reject do |s|
        s.strip.empty?
      end[0, options[:sentences]].map do |s|
        s.strip
      end.join(' ')
    end

    a = s.split(/\s/)
    n = options[:words]
    a[0...n].join(' ') + (a.size > n ? '...' : '')
  end

  def insert_emption_icons(s)
    s.gsub(/:\)/, image_tag('emotion-smile.png'))
  end
end
