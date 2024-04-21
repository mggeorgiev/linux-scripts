#!/bin/bash

convert /home/martin/Desktop/2/*.jpg -colorspace Gray -rotate 270 /home/martin/Desktop/2/myPDF%03d-gs.jpg
convert /home/martin/Desktop/2/*.jpg /home/martin/Desktop/2/myPDF%03d.pdf

for dir in `ls $YOUR_TOP_LEVEL_FOLDER`;
do
    for subdir in `ls $YOUR_TOP_LEVEL_FOLDER/$dir`;
    do
      	convert *.jpg -colorspace Gray -rotate 270 myPD
	convert *.jpg myPDF%03d.pdf
	rm *.jpg
    done
done

#convert /home/martin/Desktop/2/*.jpg -colorspace Gray -rotate 270 /home/martin/Desktop/2/myPDF%03d-gs.jpg
#convert /home/martin/Desktop/2/*.jpg /home/martin/Desktop/2/myPDF%03d.pdf
