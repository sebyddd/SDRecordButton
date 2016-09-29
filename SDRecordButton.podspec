Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "SDRecordButton"
  s.version      = "1.0.2"
  s.summary      = "A handy UIButton subclass, meant to be used as a recording button."
  s.homepage     = "https://github.com/sebyddd/SDRecordButton"
  s.screenshots  = "https://dl.dropboxusercontent.com/s/9954jio68aqu5t6/sdrecordbutton2.png?dl=0"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Sebastian Dobrincu" => "sebyddd@gmail.com" }
  s.platform     = :ios
  s.ios.deployment_target = '7.0'
  s.source       = { :git => 'https://github.com/sebyddd/SDRecordButton.git', :tag => "#{s.version}" }
  s.source_files  = "SDRecordButton/*.{h,m}"

  s.requires_arc = true

end