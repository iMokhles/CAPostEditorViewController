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
  s.source           = { :git => "https://github.com/iMokhles/CAPostEditorViewController.git", :commit => "8af2b74260c5fb6ea282134aa18aee1adec2e20e", :tag => "v1.0" }
  s.social_media_url = 'https://twitter.com/iMokhles'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.{h,m}'
  s.resources = "Resources/*.{png,xib}"
   
  s.frameworks = 'UIKit', 'Foundation'
end
