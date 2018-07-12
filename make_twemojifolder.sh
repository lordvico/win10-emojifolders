#!/bin/bash
script_dir="${0%/*}"
cd $script_dir

# Start this bash with the twemoji svg folder as a argument
# e.g.:make_twemojilibrary.sh <path to your Twemoji folder>\2\svg
emoji_dir=$1

# Folder where you extracted the standard Windows folder icon
baseicons_dir=$script_dir/src/folder
# Temp dir
set temp_dir=$script_dir/tmp
# The dir where the finished icons are stored
set final_dir=$script_dir/bin/folder

mkdir $final_dir

for f in $emoji_dir/*.*; do
	echo "Processing $f file..."
	# Pasta temporária
	mkdir $temp_dir/${f%.*}
	cd $temp_dir/${f%.*}
	
	# Processa svg do emoji
	convert -resize 120x120 -background none $emoji_dir/$f emoji_256.png
	convert -resize 32x32 -background none  $emoji_dir/$f emoji_64.png
	convert -resize 24x24 -background none  $emoji_dir/$f emoji_48.png
	convert -resize 20x20 -background none  $emoji_dir/$f emoji_40.png
	convert -resize 16x16 -background none  $emoji_dir/$f emoji_32.png
	convert -resize 12x12 -background none  $emoji_dir/$f emoji_24.png 
	convert -resize 10x10 -background none  $emoji_dir/$f emoji_20.png
	convert -resize 16x16 -background none  $emoji_dir/$f emoji_16.png
	
	# Composite the folder icon
	convert $baseicons_dir/256.png emoji_256.png -gravity SouthEast -geometry +16+29 -composite "compositeicon_256.png"
	convert $baseicons_dir/64.png emoji_64.png -gravity SouthEast -geometry +4+6 -composite "compositeicon_64.png"
	convert $baseicons_dir/48.png emoji_48.png -gravity SouthEast -geometry +3+6 -composite "compositeicon_48.png"
	convert $baseicons_dir/40.png emoji_40.png -gravity SouthEast -geometry +2+5 -composite "compositeicon_40.png"
	convert $baseicons_dir/32.png emoji_32.png -gravity SouthEast -geometry +3+3 -composite "compositeicon_32.png"
	convert $baseicons_dir/24.png emoji_24.png -gravity SouthEast -geometry +1+3 -composite "compositeicon_24.png"
	convert $baseicons_dir/20.png emoji_20.png -gravity SouthEast -geometry +2+2 -composite "compositeicon_20.png"
	cp emoji_16.png compositeicon_16.png
	
	# Make the .ico	
	convert compositeicon_256.png compositeicon_64.png compositeicon_48.png compositeicon_40.png compositeicon_32.png compositeicon_24.png compositeicon_20.png compositeicon_16.png $final_dir/${f%.*}.ico

	# Clear screen
	# clear
done

cd $script_dir
rm -rf $temp_dir

read -n1 -r -p "Press any key to continue..." key
