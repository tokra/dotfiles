#!/bin/bash

##### Constants
tvshows_folder="/Volumes/media/tvshows"
tvshow_name="Supernatural"
tvshow_dir="${tvshows_folder}/${tvshow_name}"
subtitle_types="srt"
inputEncoding="CP1250"
outputEncoding="UTF-8"
removeInput=true

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
        file -I "$1" | cut -f 2 -d";" | cut -f 2 -d=
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

##### Start
echo -e "Converting subtitles of tv show: '$tvshow_name' ...started\n"
i=1
find "$tvshow_dir" -type d -maxdepth 1 | while read season; do
    if [ "$i" -eq "1" ]; then #1st result is directory itself
        echo $season > ".readtmp"
    else
        echo -e "Reading season: '`getLastDir "$season"`' ...started"
        find "$season" -name '*.srt' -type f -maxdepth 1 | while read originalFilePath; do

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
    fi
    let i=i+1
done
root=`cat .readtmp`
rm ".readtmp"
echo -e "\nRead all seasons in: '$root'' ...finished"
echo -e "\nConverting subtitles of tv show: '$tvshow_name' ...finished\n"