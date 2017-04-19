#!/bin/sh

#Define the minimum size we'll resize to, default is 16x16px
minSize="16"

#Usage: ./AppIconResizer.sh <LARGEST_DESIRED_SIZE> <IMAGE_PATH>
#       Ex: ./AppIconResizer.sh 1024 MyFullResIcon.png
#       This example would create copies of 'MyFullResIcon.png' which have
#       been resized to 1024x1024, 512x512, 256x256, 128x128, and so on,
#       down to the minimum size (defaults to 16x16). By default the new
#       copies have the same file name as the original, simply appended
#       with the new size (e.g. 'MyFullResIcon1024.png', 'MyFullResIcon512.png')
#

if [ $# -ne 2 ]
then
echo "$(basename $0): Expecting 2 arguments: [1] the largest target size for the new files, and [2] a path to the original image file (in a standard raster format such as PNG)."
echo "Usage:"
echo "\tAppIconResizer.sh <LARGEST_DESIRED_SIZE> <IMAGE_PATH>\n\tEx: ./AppIconResizer.sh 1024 MyFullResIcon.png\n\tThis example would create copies of 'MyFullResIcon.png' which have been resized to 1024x1024, 512x512, 256x256, 128x128, and so on, down to the minimum size (defaults to 16x16). By default the new copies have the same file name as the original, simply appended with the new size (e.g. 'MyFullResIcon1024.png', 'MyFullResIcon512.png'). For more information: "
exit 1
fi

inputSize=$1
inputFile=$2

currentSize=$inputSize

filename=$(basename "$inputFile")
extension="${filename##*.}"
filename="${filename%.*}"
directory=`dirname $inputFile`

conversionStep=0
stepsPerConversion=2
totalConversionSteps=`echo "((l($inputSize)/l(2)) - (l($minSize)/l(2)) + 1) * $stepsPerConversion" | bc -l`

printStatus() {
    printf "\n\t$1"
}

calcConversionProgress() {
    printf "%.2f" $(echo "$1 / $2 * 100.0" | bc -l)
}

finishedStep() {
    conversionStep=$(( conversionStep += 1 ))
}

printf "`basename $0`: Creating app icons...\n\t"

while (( $minSize <= $currentSize ))
do
    outputFilename=$filename$currentSize".$extension"
    outputFile=$directory"/"$outputFilename

    progress=$(calcConversionProgress $conversionStep $totalConversionSteps)
    printStatus "[$progress%%]: Creating new image $outputFile..."
    cp $inputFile $outputFile
    finishedStep

    progress=$(calcConversionProgress $conversionStep $totalConversionSteps)
    printStatus "[$progress%%]: Resizing $outputFilename..."
    sips -Z $currentSize $outputFile &> /dev/null
    finishedStep

    currentSize=$(( $currentSize / 2 ))
done

progress=$(calcConversionProgress $conversionStep $totalConversionSteps)
printStatus "[$progress%%]: Done.\n"

exit 0
