Pod::Spec.new do |s|
  s.name             = 'WireGuardKit'
  s.version          = '0.0.1'
  s.summary          = 'Reusable WireGuard components for Apple platforms.'
  s.description      = <<-DESC
    Swift helpers and C/Go bridges from the official wireguard-apple project, packaged for
    CocoaPods so apps can embed WireGuard tunnels without using Swift Package Manager.
  DESC
  s.homepage         = 'https://www.wireguard.com/'
  s.license          = { :type => 'MIT', :file => 'COPYING' }
  s.author           = { 'WireGuard LLC' => 'team@wireguard.com' }
  s.source           = { :git => 'https://github.com/WalterGoldenOwl/wireguard-apple.git', :branch => 'master' }
  s.swift_version    = '5.6'

  s.platform         = :ios, '15.0'
  s.osx.deployment_target = '12.0'

  s.requires_arc = true
  s.default_subspec = 'Core'

  s.subspec 'CBridge' do |ss|
    ss.source_files        = 'Sources/WireGuardKitC/**/*.{c}'
    ss.public_header_files = 'Sources/WireGuardKitC/WireGuardKitC.h',
                             'Sources/WireGuardKitC/key.h',
                             'Sources/WireGuardKitC/x25519.h'
    ss.header_mappings_dir = 'Sources/WireGuardKitC'
    ss.preserve_paths      = 'Sources/WireGuardKitC/module.modulemap'
  end

  s.subspec 'GoBridge' do |ss|
    ss.source_files        = 'Sources/WireGuardKitGo/dummy.c'
    ss.public_header_files = 'Sources/WireGuardKitGo/wireguard.h'
    ss.header_mappings_dir = 'Sources/WireGuardKitGo'
    ss.preserve_paths      = [
      'Sources/WireGuardKitGo/module.modulemap',
      'Sources/WireGuardKitGo/wireguard.h',
      'Sources/WireGuardKitGo/api-apple.go',
      'Sources/WireGuardKitGo/go.mod',
      'Sources/WireGuardKitGo/go.sum',
      'Sources/WireGuardKitGo/Makefile',
      'Sources/WireGuardKitGo/goruntime-*.diff'
    ]
    ss.pod_target_xcconfig = {
      'LIBRARY_SEARCH_PATHS' => '$(inherited) $(CONFIGURATION_BUILD_DIR)',
      'OTHER_LDFLAGS' => '$(inherited) -lwg-go'
    }
    ss.script_phase = {
      :name => 'Build wireguard-go bridge',
      :execution_position => :before_compile,
      :shell_path => '/bin/sh',
      :input_files => ["${PODS_TARGET_SRCROOT}/Sources/WireGuardKitGo/api-apple.go", "${PODS_TARGET_SRCROOT}/Sources/WireGuardKitGo/go.mod"],
      :output_files => ["${CONFIGURATION_BUILD_DIR}/libwg-go.a", "${CONFIGURATION_BUILD_DIR}/wireguard-go-version.h"],
      :script => <<-'SCRIPT'
set -euo pipefail

if ! command -v go >/dev/null 2>&1; then
  echo "[WireGuardKit] Go toolchain not found. Install Go 1.19 or newer." >&2
  exit 1
fi

SOURCE_ROOT="${PODS_TARGET_SRCROOT}/Sources/WireGuardKitGo"
BUILD_DIR="${CONFIGURATION_BUILD_DIR}"
TEMP_DIR="${CONFIGURATION_TEMP_DIR}/wireguard-go-bridge"
ARCH_LIST="${ARCHS:-$(uname -m)}"
PLATFORM_NAME="${PLATFORM_NAME:-iphoneos}"
SDK_PATH="${SDKROOT:-$(xcrun --sdk ${PLATFORM_NAME} --show-sdk-path)}"

make -C "${SOURCE_ROOT}" \
  ARCHS="${ARCH_LIST}" \
  PLATFORM_NAME="${PLATFORM_NAME}" \
  SDKROOT="${SDK_PATH}" \
  CONFIGURATION_BUILD_DIR="${BUILD_DIR}" \
  CONFIGURATION_TEMP_DIR="${TEMP_DIR}" \
  install

make -C "${SOURCE_ROOT}" \
  ARCHS="${ARCH_LIST}" \
  PLATFORM_NAME="${PLATFORM_NAME}" \
  SDKROOT="${SDK_PATH}" \
  CONFIGURATION_BUILD_DIR="${BUILD_DIR}" \
  CONFIGURATION_TEMP_DIR="${TEMP_DIR}" \
  version-header
SCRIPT
    }
  end

  s.subspec 'Core' do |ss|
    ss.dependency 'WireGuardKit/CBridge'
    ss.dependency 'WireGuardKit/GoBridge'
    ss.source_files = 'Sources/WireGuardKit/**/*.swift'
    ss.pod_target_xcconfig = {
      'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) WIREGUARDKIT_COCOAPODS'
    }
  end

  s.user_target_xcconfig = {
    'ENABLE_BITCODE' => 'NO'
  }
end
