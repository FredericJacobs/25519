Pod::Spec.new do |spec|
  spec.name         = '25519'
  spec.version      = '2.0.2'
  spec.license      = { :type => 'GPLv3' }
  spec.homepage     = 'https://github.com/FredericJacobs/25519'
  spec.preserve_path = 'Sources/ed25519/**/*.{c,h}'
  spec.authors      = { 'Frederic Jacobs' => 'github@fredericjacobs.com' }
  spec.summary      = 'Key agreement (curve25519) and signing (ed25519), all with curve25519 keys.'

  spec.description  =  <<-DESC
    Curve25519 is a fast and secure curve used for key agreement. Unfortunately, it does not support signing out of the box. This pod translates the point curves to do ed25519 signing with curve25519 keys.
  DESC

  spec.source       = { :git => 'https://github.com/FredericJacobs/25519.git', :tag => "#{spec.version}" }
  spec.source_files = 'Classes/*.{h,m}', 'Sources/Curve25519/curve25519-donna.c', 'Sources/ed25519/*.{c,h}', 'Sources/ed25519/additions/*.{c,h}', 'Sources/ed25519/nacl_sha512/*.{c,h}', 'Sources/ed25519/nacl_includes/*.{c,h}'
  #spec.private_header_files = 'Sources/ed25519/nacl_includes/*.h','Sources/ed25519/additions/*.h', 'Sources/ed25519/nacl_sha512/*.h'
  spec.framework    = 'Security'
  spec.public_header_files = "Classes/*.h"
  spec.requires_arc = true
end
