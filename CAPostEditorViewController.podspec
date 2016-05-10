Pod::Spec.new do |s|
  s.name             = "CAPostEditorViewController"
  s.version          = "1.0"
  s.summary          = "simple compose view controller with a lot of customizations properties."

  s.description      = <<-DESC
                       simple compose view controller with a lot of customizations properties
                       DESC

  s.homepage         = "https://github.com/iMokhles/CAPostEditorViewController"
  s.license          = 'MIT'
  s.author           = { "iMokhles" => "mokhleshussien@aol.com" }
  s.source           = { :git => "https://github.com/iMokhles/CAPostEditorViewController.git", :commit => "aeec0c6cc6c8d3d168e84be5f2da4405f7f00988", :tag => "v1.0" }
  s.social_media_url = 'https://twitter.com/iMokhles'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'
  s.resources = "Resources/*.{png,xib}"
   
  s.frameworks = 'UIKit', 'Foundation'
end
