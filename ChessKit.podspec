#
#  Be sure to run `pod spec lint ChessKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "ChessKit"
  spec.version      = "1.3.7"
  spec.summary      = "Lightweight and fast chess framework written in Swift."
  
  spec.description  = "Lightweight and fast chess framework written in Swift. ChessKit is used as a base freamework for Ladoga chess engine."

  spec.homepage     = "https://aperechnev.github.io/ChessKit/"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Alexander Perechnev" => "alexander@perechnev.com" }

  spec.ios.deployment_target = "8.0"
  spec.osx.deployment_target = "10.9"
  spec.swift_version = "5.2"

  spec.source       = { :git => "https://github.com/aperechnev/ChessKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/**/*.swift"
  spec.exclude_files = "Classes/Exclude"
end
