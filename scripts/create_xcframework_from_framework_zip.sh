#!/usr/bin/env bash
set -euo pipefail

# Create an XCFramework from a zipped .framework that contains arm64 + x86_64 slices.
#
# Usage:
#   ./scripts/create_xcframework_from_framework_zip.sh \
#     /path/to/CocoaDebug.framework.zip \
#     /path/to/output/CocoaDebug.xcframework
#
# Notes:
# - Uses -allow-internal-distribution (needed when no .swiftinterface is present).
# - Assumes framework name is CocoaDebug.framework inside the zip.

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "Usage: $0 <framework_zip_path> [output_xcframework_path]" >&2
  exit 1
fi

ZIP_PATH="$1"
OUTPUT_PATH="${2:-CocoaDebug.xcframework}"

if [[ ! -f "$ZIP_PATH" ]]; then
  echo "Error: zip not found at: $ZIP_PATH" >&2
  exit 1
fi

WORK_DIR="$(mktemp -d /tmp/cocoadebug_xcframework.XXXXXX)"
trap 'rm -rf "$WORK_DIR"' EXIT

UNPACK_DIR="$WORK_DIR/unpack"
DEVICE_DIR="$WORK_DIR/device"
SIM_DIR="$WORK_DIR/sim"

mkdir -p "$UNPACK_DIR" "$DEVICE_DIR" "$SIM_DIR"

unzip -q "$ZIP_PATH" -d "$UNPACK_DIR"

SRC_FRAMEWORK="$UNPACK_DIR/CocoaDebug.framework"
if [[ ! -d "$SRC_FRAMEWORK" ]]; then
  echo "Error: CocoaDebug.framework not found inside zip." >&2
  exit 1
fi

cp -R "$SRC_FRAMEWORK" "$DEVICE_DIR/CocoaDebug.framework"
cp -R "$SRC_FRAMEWORK" "$SIM_DIR/CocoaDebug.framework"

# Remove packaging-only script and normalize non-binary executable permissions.
for SLICE in "$DEVICE_DIR/CocoaDebug.framework" "$SIM_DIR/CocoaDebug.framework"; do
  rm -f "$SLICE/copy_and_codesign.sh"
  find "$SLICE" -type f -perm -111 ! -name CocoaDebug -exec chmod 0644 {} +
done

# Thin device/simulator binaries.
lipo "$DEVICE_DIR/CocoaDebug.framework/CocoaDebug" \
  -thin arm64 \
  -output "$DEVICE_DIR/CocoaDebug.framework/CocoaDebug"
lipo "$SIM_DIR/CocoaDebug.framework/CocoaDebug" \
  -thin x86_64 \
  -output "$SIM_DIR/CocoaDebug.framework/CocoaDebug"

# Remove unrelated swiftmodule files per slice if present.
SWIFTMODULE_DEVICE="$DEVICE_DIR/CocoaDebug.framework/Modules/CocoaDebug.swiftmodule"
SWIFTMODULE_SIM="$SIM_DIR/CocoaDebug.framework/Modules/CocoaDebug.swiftmodule"
if [[ -d "$SWIFTMODULE_DEVICE" ]]; then
  find "$SWIFTMODULE_DEVICE" -type f \( -name 'x86_64*' -o -name '*ios-simulator*' \) -delete
fi
if [[ -d "$SWIFTMODULE_SIM" ]]; then
  find "$SWIFTMODULE_SIM" -type f \( -name 'arm64*' -o -name '*apple-ios.swiftmodule' -o -name '*apple-ios.swiftdoc' \) -delete
fi

# Adjust simulator framework metadata.
/usr/libexec/PlistBuddy -c "Set :CFBundleSupportedPlatforms:0 iPhoneSimulator" "$SIM_DIR/CocoaDebug.framework/Info.plist"
/usr/libexec/PlistBuddy -c "Set :DTPlatformName iphonesimulator" "$SIM_DIR/CocoaDebug.framework/Info.plist"
/usr/libexec/PlistBuddy -c "Set :DTSDKName iphonesimulator14.4" "$SIM_DIR/CocoaDebug.framework/Info.plist"

rm -rf "$OUTPUT_PATH"
xcodebuild -create-xcframework \
  -framework "$DEVICE_DIR/CocoaDebug.framework" \
  -framework "$SIM_DIR/CocoaDebug.framework" \
  -output "$OUTPUT_PATH" \
  -allow-internal-distribution

echo "Created: $OUTPUT_PATH"
echo "Inspect:"
echo "  plutil -p \"$OUTPUT_PATH/Info.plist\""
