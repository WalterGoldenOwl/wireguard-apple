Pod::Spec.new do |s|
  s.name         = 'WireGuardKit'
  s.version      = '1.0.0'
  s.summary      = 'Unified WireGuard Apple Kit'
  s.description  = 'WireGuard Apple implementation.'
  s.homepage     = 'https://www.wireguard.com'
  s.license      = { :type => 'MIT', :file => 'COPYING' }
  s.author       = { 'WireGuard' => 'team@wireguard.com' }

  s.platform     = :ios, '15.0'
  s.swift_version = '5.0'
  s.requires_arc = true

  s.source = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }

  # Bao gồm tất cả các tệp nguồn và không phải nguồn
  s.source_files = 'Sources/WireGuardKit/**/*', 'Sources/WireGuardKitC/**/*', 'Sources/WireGuardKitGo/**/*'
  s.public_header_files = 'Sources/WireGuardKit/**/*.h', 'Sources/WireGuardKitC/**/*.h', 'Sources/WireGuardKitGo/**/*.h'
  s.preserve_paths = 'Sources/**/*', 'sync-translations.sh', 'WireGuard.xcodeproj', '.swiftlint.yml', 'README.md', 'COPYING', '.gitignore', 'Package.swift'
end