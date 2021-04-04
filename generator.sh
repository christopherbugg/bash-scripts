#!/bin/bash

# generator.sh
# Chris Bugg
# 2021.03.31

# This simple script is a static-site-generator.
#  It takes some standard assets (header/footer/etc.)
#  and some pages (really just <body>s in files) and
#  glues them together in a destination folder.

### Varibles to configure:

# Where the header/footer assets are located
header="./parts/assets/header.html";
footer="./parts/assets/footer.html";

# Where all the pages (body sections) are
pages="./parts/pages/";

# Where should the new files be built
destination="./site/";

### End Variables to configure

# Clear out the old build
rm -rf $destination*;

# Copy over pages and dirs to destination
cp -r $pages* $destination;

# Get the full path
destination_full_path=$(readlink -f $destination);

# For each page we have... (not white-space friendly)
for file in $(find $destination_full_path -name "*.html");
do

	# Save body to temp file
	cp $file body.tmp

	# Fill with header
	cat $header > $file;

	# Fill with body
	cat body.tmp >> $file;

	# Fill with footer
	cat $footer >> $file;

	# Remove temp file
	rm body.tmp

	# Speak of our successes!
	echo "Created $file";

done
