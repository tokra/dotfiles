#!/bin/bash

##### Constants
tvshows_folder=""
tvshow_name=""
subtitle_types="srt"
inputEncoding="CP1250"
outputEncoding="UTF-8"
removeInput=true
season_number=all

##### Functions
function convertSubtitles () {
    echo -e "\n> Start converting from 'CP1250' to 'UTF-8' ..."

    echo -e "\t>> Orig file name    : $1"
    echo -e "\t>> Encoding          : '`getFileCharset "$1"`'"

    echo -e "\t>> New file name     : $2"
    echo -e "\t>> Encoding          : '`getFileCharset "$2"`'"

    # convert
    iconv -f "${inputEncoding}" -t "${outputEncoding}" "${1}" > "${2}"
    echo -e "> Convert from: CP1250 to: UTF-8\n\t>>from: $1 to: $2 ...done"
}

function getFileCharset () {
    if [ -f "$1" ] ; then
        file --mime "$1" | cut -f 2 -d";" | cut -f 2 -d=
    else
        echo "file does not exist !"
    fi
}

function isUnknown8bit () {
    if [ "unknown-8bit" == "`getFileCharset "$1"`" ] ; then
        return 0
    fi
    return 1
}

function isUtf8 () {
    if [ "utf-8" == "`getFileCharset "$1"`" ] ; then
        return 0
    fi
    return 1
}

function getFilename () {
    filePath="$1"
    echo "$filePath" | rev | cut -d"." -f2- | rev
}

function getExtension () {
    filePath="$1"
    echo "$filePath" | rev | cut -d"." -f2  | rev
}

function getLastDir () {
    echo "$1" | rev | cut -f1 -d"/" | rev
}

function getAllSeasons () {
    all_seasons=`find "$1" -type d -maxdepth 1 -regex '.*s[0-9][0-9]' | sort -t '\0' -n | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/ /g'`
    echo $all_seasons
}

function implementationMissing () {
    echo -e "\nImplementation for converting only season '$1' is missing !"
}

function printConvertStart () {
    echo -e "\nConverting subtitles of tv show: '$tvshow_name' ...started"
}

function printConvertStop () {
    echo -e "\nConverting subtitles of tv show: '$tvshow_name' ...finished"
}

##### Start

# read params
while :; do
  case "$1" in
    -h|-\?|--help)
        helpmsg
        exit 0
        ;;
    -f|--tvshowfolder) # TV shows folder root
        tvshows_folder="`realpath $2`"
        shift
        ;;
    -n|--tvshowname) # TV show name
        tvshow_name="$2"
        shift
        ;;
    -t|--subtitletypes) # Subtitle type: srt, sub...
        subtitle_types="$2"
        shift
        ;;
    -s|--seasonnumber) # Season number
        season_number="$2"
        shift
        ;;
    -i|--inputencoding) # Input encoding: CP1250...
        inputEncoding="$2"
        shift
        ;;
    -o|--outpuencoding) # Output encoding: UTF-8...
        outpuencoding="$2"
        shift
        ;;
    -r|--removeinput) # Remove original subtitle file
        removeInput="$2"
        shift
        ;;
    --) # End of all options
        break
        ;;
    -?*)
        echo "Unknown option (ignored): $1" >&2
        ;;
    *) # Default case: if no more options then break out of loop
        break
  esac
  shift
done

# print input variables
tvshow_dir="${tvshows_folder}/${tvshow_name}"
echo "tv shows folder : $tvshow_dir"
echo "tv show name    : $tvshow_name"
echo "subtitle types  : $subtitle_types"
echo "input encoding  : $inputEncoding"
echo "output encoding : $outputEncoding"
echo "remove input    : $removeInput"
echo "season number   : $season_number"

# get all seasons
declare -a seasons=(`getAllSeasons "$tvshow_dir"`)
echo -e "\nFound these seasons:"
for season in "${seasons[@]}"
do
    echo "$season"
done

# convert
case "$season_number" in
    all|a)
        printConvertStart
        for season in "${seasons[@]}"
        do
            printf "\n"
            echo -e "Reading season: '`getLastDir "$season"`' ...started"
            find "$season" -name '*.srt' -type f -maxdepth 1 | 
        
            while read originalFilePath; 
            do
                outputFilePath=""
                if [[ "$originalFilePath" == *.cs.srt ]]; then
                    filename=`echo $originalFilePath | sed 's/.cs\.srt.*//'`
                    outputFilePath="$filename.cs.srt"
                    echo -e "\nFile: '$outputFilePath' already exist !"
                    if isUtf8 "$outputFilePath" ; then
                        echo "File: '$outputFilePath' already 'utf-8' !"
                        echo "> Skipping character encoding !"
                    else
                        rm -rf "$outputFilePath"
                        if isUnknown8bit "$originalFile" ; then
                            convertSubtitles "$originalFile" "$outputFilePath"
                        fi
                    fi
                else
                    originalFilePathWithoutExtension="`getFilename "$originalFilePath"`"
                    outputFilePath="$originalFilePathWithoutExtension.cs.srt"
                    if [ ! -f "$outputFilePath" ]; then
                        if isUnknown8bit "$originalFilePath" ; then
                            convertSubtitles "$originalFilePath" "$outputFilePath"
                            if $removeInput ; then
                                echo "> Removing original file: '$originalFilePath'"
                                rm -rf "$originalFilePath"
                            fi
                        else
                            echo "originalFilePath  : $originalFilePath"
                            echo "outputFilePath    : $outputFilePath"
                            echo "> Skipping character encoding !"
                        fi
                    fi
                fi
            done
            echo -e "\nReading season: '`getLastDir "$season"`' ...finished"
        done
        echo -e "\nRead all seasons in: '$tvshows_folder'' ...finished"
        printConvertStop
        shift
        ;;
    1)
        implementationMissing "$season_number"
        shift
        ;;
    2)
        implementationMissing "$season_number"
        shift
        ;;
    3)
        implementationMissing "$season_number"
        shift
        ;;
    4)
        implementationMissing "$season_number"
        shift
        ;;
    5)
        implementationMissing "$season_number"
        shift
        ;;
    6)
        implementationMissing "$season_number"
        shift
        ;;
    7)
        implementationMissing "$season_number"
        shift
        ;;
    8)
        implementationMissing "$season_number"
        shift
        ;;
    9)
        implementationMissing "$season_number"
        shift
        ;;
    10)
        implementationMissing "$season_number"
        shift
        ;;
    *) # Default case
        echo "Undefined 'season number' (ignored): $season_number">&2
        ;;
esac
