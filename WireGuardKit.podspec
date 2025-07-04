Pod::Spec.new do |s|
  s.name             = 'WireGuardKit'
  s.version          = '1.0.0'
  s.summary          = 'WireGuard implementation for iOS'
  s.homepage         = 'https://github.com/your-repo'
  s.license          = { :type => 'MIT', :file => 'COPYING' }
  s.author           = { 'Your Name' => 'your@email.com' }
  s.source           = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }
  
  s.ios.deployment_target = '15.0'
  s.swift_version    = '5.0'
  
  # 1. Khai báo toàn bộ cấu trúc thư mục ảo
  s.preserve_paths = '**/*'
  
  # 2. Sử dụng subspecs để ánh xạ chính xác nguồn
  s.subspec 'WireGuardKitC' do |c|
    c.source_files = 'Sources/WireGuardKitC/**/*.{c,h}'
    c.public_header_files = 'Sources/WireGuardKitC/**/*.h'
    c.private_header_files = 'Sources/WireGuardKitC/**/*.h'
    c.header_mappings_dir = 'Sources/WireGuardKitC'
  end

  s.subspec 'WireGuardKit' do |swift|
    swift.source_files = 'Sources/WireGuardKit/**/*.swift'
    swift.dependency 'WireGuardKit/WireGuardKitC'
  end

  s.subspec 'WireGuardKitGo' do |go|
    go.source_files = 'Sources/WireGuardKitGo/**/*.{swift,h,m}'
    go.dependency 'WireGuardKit/WireGuardKitC'
  end

  # 3. Tạo subspec chính để gộp tất cả
  s.default_subspecs = 'WireGuardKitC', 'WireGuardKit', 'WireGuardKitGo'
  
  # 4. Tuỳ chỉnh cài đặt post-install
  s.script_phase = {
    :name => 'Preserve Directory Structure',
    :script => 'echo "Directory structure preserved"',
    :execution_position => :after_compile
  }
end