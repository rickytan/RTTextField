Pod::Spec.new do |s|

  s.name         = "RTTextField"
  s.version      = "0.5.0"
  s.summary      = "A dropin replacement for UITextField with input limitation."
  s.description  = <<-DESC
		   This is a dropin replacement for UITextField, which can limit the use's input by specifing a valid input pattern.
                   DESC

  s.homepage     = "https://github.com/rickytan/RTTextField"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "rickytan" => "ricky.tan.xin@gmail.com" }
  s.social_media_url   = "https://xcoder.tips"
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/rickytan/RTTextField.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  s.frameworks = "UIKit"
  s.requires_arc = true
end
