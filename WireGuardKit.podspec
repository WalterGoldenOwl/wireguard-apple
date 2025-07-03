Pod::Spec.new do |spec|
  spec.name         = "WireGuardKit"
  spec.version      = "1.0.0"
  spec.summary      = "WireGuard implementation for iOS"
  spec.description  = <<-DESC
                      WireGuard implementation for iOS with complete project structure preservation.
                      Includes WireGuard protocol implementation, network extension, and shared components.
                      DESC
  
  spec.homepage     = "https://github.com/WalterGoldenOwl/wireguard-apple.git"
  spec.license      = { :type => "MIT", :file => "COPYING" }
  spec.author       = { "Your Name" => "your.email@example.com" }
  
  spec.platform     = :ios, "15.0"
  spec.ios.deployment_target = "15.0"
  
  spec.source = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }
  
  # Preserve original directory structure
  spec.preserve_paths = "Sources/**/*"
  
  # Use header_mappings_dir to maintain folder structure
  spec.header_mappings_dir = "Sources"
  
  # Define source files while preserving structure
  spec.source_files = [
    "Sources/WireGuardKit/**/*.{h,m,swift}",
    "Sources/WireGuardKitC/**/*.{h,c,m}",
    "Sources/WireGuardKitGo/**/*.{h,m,go}",
  ]
  
  # Public headers with directory structure
  spec.public_header_files = [
    "Sources/WireGuardKit/**/*.h",
    "Sources/WireGuardKitC/**/*.h",
    "Sources/WireGuardKitGo/**/*.h"
  ]
  
  # Frameworks and libraries
  spec.frameworks = [
    "Foundation",
    "UIKit",
    "NetworkExtension",
    "Security"
  ]
  
  spec.libraries = ["c++", "resolv"]
  
  # Build configuration to preserve structure
  spec.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'VALID_ARCHS' => 'arm64 x86_64',
    'SWIFT_VERSION' => '5.0',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'HEADER_SEARCH_PATHS' => '$(PODS_TARGET_SRCROOT)/Sources/**',
    'SWIFT_INCLUDE_PATHS' => '$(PODS_TARGET_SRCROOT)/Sources/**'
  }
  
  # Module map to maintain structure
  spec.module_map = false
  
  # Custom module map content
  spec.prepare_command = <<-CMD
    echo "Preparing WireGuardKit with preserved structure..."
    
    # Create custom module map to preserve structure
    cat > WireGuardKit.modulemap << 'EOF'
module WireGuardKit {
  umbrella header "WireGuardKit.h"
  export *
  module * { export * }
  
  explicit module WireGuardKit {
    header "Sources/WireGuardKit/WireGuardKit.h"
    export *
  }
  
  explicit module Shared {
    header "Sources/Shared/Shared.h"
    export *
  }
  
  explicit module WireGuardKitC {
    header "Sources/WireGuardKitC/WireGuardKitC.h"
    export *
  }
  
  explicit module WireGuardKitGo {
    header "Sources/WireGuardKitGo/WireGuardKitGo.h"
    export *
  }
  
  explicit module WireGuardNetworkExtension {
    header "Sources/WireGuardNetworkExtension/WireGuardNetworkExtension.h"
    export *
  }
  
  explicit module WireGuardApp {
    header "Sources/WireGuardApp/WireGuardApp.h"
    export *
  }
}
EOF
    
    # Make sync script executable if exists
    if [ -f "sync-translations.sh" ]; then
      chmod +x sync-translations.sh
    fi
  CMD
  
  # Resources with structure preservation
  spec.resource_bundles = {
    'WireGuardKit' => [
      'Sources/**/*.{storyboard,xib,xcassets,strings,plist,json}'
    ]
  }
  
  # Swift version
  spec.swift_version = "5.0"
  spec.requires_arc = true
  
  # File hierarchy specification
  spec.header_dir = "WireGuardKit"
  
  # Alternative approach: Use subspecs with proper structure
  spec.default_subspec = 'All'
  
  spec.subspec 'All' do |all|
    all.source_files = [
      "Sources/WireGuardKit/**/*.{h,m,swift}",
      "Sources/WireGuardKitC/**/*.{h,c,m}",
      "Sources/WireGuardKitGo/**/*.{h,m,go}"
    ]
    
    all.preserve_paths = "Sources/**/*"
    all.header_mappings_dir = "Sources"
    
    # Preserve individual directory structures
    all.pod_target_xcconfig = {
      'HEADER_SEARCH_PATHS' => [
        '$(PODS_TARGET_SRCROOT)/Sources/WireGuardKit',
        '$(PODS_TARGET_SRCROOT)/Sources/WireGuardKitC',
        '$(PODS_TARGET_SRCROOT)/Sources/WireGuardKitGo'
      ].join(' '),
      'SWIFT_INCLUDE_PATHS' => [
        '$(PODS_TARGET_SRCROOT)/Sources/WireGuardKit'
      ].join(' ')
    }
  end
end