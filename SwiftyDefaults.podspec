

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SwiftyDefaults"
  s.version      = "1.0.1"
  s.summary      = "strong type of UserDefaults. convenient and useful API"

  s.description  = <<-DESC
    A strong type of UserDefaults by Swift, more convenience
                   DESC
  s.homepage     = "https://github.com/Zafirzzf/SwiftyDefaults"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "zhouzf" => "Zoolofty@163.com" }
  # Or just: s.author    = "zhouzf"
  # s.social_media_url   = "http://twitter.com/zhouzf"
  # s.platform     = :ios
  # s.platform     = :ios, "11.0"
    s.ios.deployment_target  = '11.0'
    s.swift_version = '5.0'
    s.source       = { :git => "https://github.com/Zafirzzf/SwiftyDefaults.git", :tag => "v1.0.1" }
    s.source_files  = "Classes/*"

end
