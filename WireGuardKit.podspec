Pod::Spec.new do |s|
  s.name         = 'WireGuardKit'
  s.version      = '1.0.0'
  s.summary      = 'Unified WireGuard Apple library'
  s.description  = 'WireGuard implementation for iOS/macOS packaged as a single pod.'
  s.homepage     = 'https://www.wireguard.com'
  s.license      = { :type => 'MIT', :file => 'COPYING' }
  s.author       = { 'WireGuard' => 'team@wireguard.com' }

  s.platform     = :ios, '12.0'
  s.swift_version = '5.0'

  s.source       = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }

  s.source_files = 'Sources/**/*.{h,m,c,cpp,swift}'

  s.public_header_files = 'Sources/**/*.h'

  s.requires_arc = true
end
