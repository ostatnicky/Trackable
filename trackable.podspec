Pod::Spec.new do |s|
  s.name = 'Trackable'
  s.version = '0.9'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Swift app analytics using protocol extensions'
  s.homepage = 'https://github.com/ostatnicky/Trackable'
  s.social_media_url = 'https://twitter.com/ostatnicky'
  s.authors = {
    "Vojta Stavik" => "stavik@outlook.com",
    "Jiri Ostatnicky" => "ostatnicky@gmail.com"
  }
  s.source = { :git => 'https://github.com/ostatnicky/Trackable.git', :tag => '0.9' }
  s.ios.deployment_target = '9.0'
  s.source_files   = 'Trackable/*.swift'
  s.frameworks = 'Foundation'
  s.requires_arc = true
end
