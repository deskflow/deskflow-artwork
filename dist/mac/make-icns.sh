if ! [ -x "$(command -v magick)" ]; then
  echo 'Error: Please install ImageMagick: brew install imagemagick' >&2
  exit 1
fi

INPUT_FILENAME=$1
FILENAME_NO_EXT="${INPUT_FILENAME%.*}"

if [ ${INPUT_FILENAME: -4} == ".svg" ]; then
  # Using a .svg from Inkscape seems to break transparency ¯\_(ツ)_/¯
  echo "Warning: Using .svg break transparency. Consider using .png instead."
fi

ICONSET_DIR="${FILENAME_NO_EXT}.iconset"
mkdir -p $ICONSET_DIR

SIZES=(16 32 64 128 256 512)

for size in "${SIZES[@]}"; do
  base_cmd="magick $INPUT_FILENAME -resize"
  $base_cmd ${size}x${size} $ICONSET_DIR/icon_${size}x${size}.png
  $base_cmd $(($size * 2))x$(($size * 2)) $ICONSET_DIR/icon_${size}x${size}@2x.png
done

iconutil -c icns $ICONSET_DIR
