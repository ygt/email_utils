require "email_utils/version"

module EmailUtils
  def self.get_email_recipients( emails )
    emails.to_s.split(";").flatten.collect{|a| a.strip unless a.strip.blank?}.compact
  end

  def self.email_regex
    word_chars = "a-zA-Z0-9_%+&-"
    local_part = "([\'#{word_chars}]+\\.)*[\'#{word_chars}]+"
    domain_part = "([#{word_chars}]+\\.)*[#{word_chars}]+"
    email = "#{local_part}@#{domain_part}"

    /\A#{email}\Z/
  end

  def self.valid_email(string)
    return !string.match( email_regex ).nil?
  end

  def self.html_to_text(html)
    html = html.dup

    html.gsub! /<\/?center>/, ''
    html.gsub! /align="center"/, ''
    html.gsub! /text-align:\s*center/, ''

    html.gsub! /<a[^>]*>[^<]*<img[^>]+>[^<]*<\/a>/, ''
    html.gsub! /<a href="mailto:[^>]*>/, '<a>'
    html.gsub! /<a href="([^"]+)"[^>]*>([^<]+)/, '<a href="\1">\2 at \1'

    html.gsub! "&times;", " x "

    text = IO.popen("lynx -dump -stdin", "r+") do |io|
      io.write html
      io.close_write
      io.read
    end

    raise "Lynx command failed to run (tip: Is lynx installed?)\n#{html}" unless $?.success?
    raise "Output from lynx command was empty!" if text.empty? or text.squish.empty?

    text.gsub! /\[[^\]]*\]/, ''
    text.gsub!(/^References.*\Z/, '')

    return text
  end
end
