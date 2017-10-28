Pod::Spec.new do |s|
  s.name        = "BeyovaJSON"
  s.version     = "0.0.1"
  s.summary     = "BeyovaJSON makes it easy to deal with JSON and Codable in Swift"
  s.homepage    = "https://github.com/Beyova/BeyovaJSON"
  s.license     = { :type => "MIT" }
  s.authors     = { "canius" => "canius.chu@outlook.com" }

  s.requires_arc = true
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"
  s.source   = { :git => "https://github.com/Beyova/BeyovaJSON.git", :tag => s.version }
  s.source_files = "Source/*.swift"
end
