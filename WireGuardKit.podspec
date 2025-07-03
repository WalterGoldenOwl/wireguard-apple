Pod::Spec.new do |s|
  s.name         = 'WireGuardKit'
  s.version      = '1.0.0'
  s.summary      = 'Unified WireGuard Apple Kit'
  s.description  = 'WireGuard Apple implementation split into subspecs.'
  s.homepage     = 'https://www.wireguard.com'
  s.license      = { :type => 'MIT', :file => 'COPYING' }
  s.author       = { 'WireGuard' => 'team@wireguard.com' }

  s.platform     = :ios, '15.0'
  s.swift_version = '5.0'
  s.requires_arc = true

  s.source = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }

  # Bao gồm các tệp không phải nguồn và thư mục Sources để giữ cấu trúc
  s.preserve_paths = 'Sources/**/*', 'sync-translations.sh', 'WireGuard.xcodeproj', '.swiftlint.yml', 'README.md', 'MOBILECONFIG.md', 'COPYING', '.gitignore', 'Package.swift'

  s.subspec 'WireGuardKit' do |kit|
    kit.source_files = 'Sources/WireGuardKit/**/*'
    kit.public_header_files = 'Sources/WireGuardKit/**/*.h'
    kit.preserve_paths = 'Sources/WireGuardKit/**/*'
  end

  s.subspec 'WireGuardKitC' do |kitc|
    kitc.source_files = 'Sources/WireGuardKitC/**/*'
    kitc.public_header_files = 'Sources/WireGuardKitC/**/*.h'
    kitc.preserve_paths = 'Sources/WireGuardKitC/**/*'
  end

  s.subspec 'WireGuardKitGo' do |go|
    go.source_files = 'Sources/WireGuardKitGo/**/*'
    go.public_header_files = 'Sources/WireGuardKitGo/**/*.h'
    go.preserve_paths = 'Sources/WireGuardKitGo/**/*'
  end
end