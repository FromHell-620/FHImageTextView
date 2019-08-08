
Pod::Spec.new do |s|
  s.name         = "FHImageTextView"
  s.version      = "1.1.2"
  s.homepage     = "https://github.com/FromHell-620/FHImageTextView"
  s.license      = "MIT"
  s.summary      = "ImageTextView"
  s.author       = { "GodL" => "547188371@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/FromHell-620/FHImageTextView.git", :tag => s.version.to_s }
  s.source_files  = "FHImageTextView/*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true
  s.dependency 'Masonry'
end
