if ! [ -x "$(command -v convert)" ]; then
  echo 'Error: convert is not installed. Please install ImageMagick.' >&2
  exit 1
fi

ICONSET_DIR="deskflow-mac-icon.iconset"
mkdir -p $ICONSET_DIR

# Use .png because using .svg as the source breaks transparency... ¯\_(ツ)_/¯
INPUT_SVG="deskflow-mac-icon.png"
SIZES=(16 32 64 128 256 512)

for size in "${SIZES[@]}"; do
  base_cmd="magick $INPUT_SVG -resize"
  $base_cmd ${size}x${size} $ICONSET_DIR/icon_${size}x${size}.png
  $base_cmd $(($size * 2))x$(($size * 2)) $ICONSET_DIR/icon_${size}x${size}@2x.png
done

iconutil -c icns $ICONSET_DIR
