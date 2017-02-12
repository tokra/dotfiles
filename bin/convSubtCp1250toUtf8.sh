#!/bin/bash

##### Constants
inputEncoding="CP1250"
outputEncoding="UTF-8"
removeOriginalFile=false

##### Functions
function getFileName () {
    echo "$1" | rev | cut -f1 -d"/" | rev
}

function getFileExt () {
    echo "$1" | cut -f2 -d"."
}

function getFileNameNoExt () {
    echo "$1" | rev | cut -f1 -d"/" | rev | cut -f1 -d"."
}

function getFileDir () {
    echo "$1" | rev | cut -f2- -d"/" | rev
}

function getFileCharset () {
    if [ -f "$1" ] ; then
        file --mime "$1" | cut -f 2 -d";" | cut -f 2 -d=
    else
        echo "file does not exist !"
    fi
}

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

##### handle input params
if [ -z "$1" ]; then
    echo "ERROR: input param is empty !!!"
    osascript -e "display notification \"ERROR: input param is empty\" with title \"Subtitles converter\""
    exit 1
fi

if [ -n "$2" ]; then
    if [ $2="--removeOriginal=true" ]; then
        removeOriginalFile=true
    fi
fi

##### variables
isZip=false
input_file_path=`/usr/local/bin/realpath "$1"`
input_file_dir=`getFileDir "$input_file_path"`

if [[ "$input_file_path" == *.zip ]]; then
    isZip=true
    input_original_file_path="$input_file_path"
    # extract file name
    unzip_file_name=`unzip -Z1 "$input_file_path"`
    input_file_path="$input_file_dir/$unzip_file_name"
    # unzip archive
    unzip -o "$input_original_file_path" -d "$input_file_dir"
fi

input_file_name=`getFileName "$input_file_path"`
input_file_name_no_ext=`getFileNameNoExt "$input_file_path"`
input_file_ext=`getFileExt "$input_file_path"`
output_file_path="$input_file_dir/$input_file_name_no_ext.utf8.$input_file_ext"

# print input variables
if $isZip ; then
    echo -e "\ninput_original_file_path : $input_original_file_path"
fi
echo "input_file_path          : $input_file_path"
echo "input_file_dir           : $input_file_dir"
echo "input_file_name          : $input_file_name"
echo "input_file_name_no_ext   : $input_file_name_no_ext"
echo "input_file_ext           : $input_file_ext"
echo "output_file_path         : $output_file_path"
echo "inputEncoding            : $inputEncoding"
echo "outputEncoding           : $outputEncoding"

# main
convertSubtitles "$input_file_path" "$output_file_path"

# remove original file
if $removeOriginalFile ; then
    rm -rf "$input_file_path"
    if $isZip ; then
        rm -rf "$input_original_file_path"
    fi
fi

mv "$output_file_path" "$input_file_path"

# macOs notification
if $isZip ; then
    osascript -e "display notification \"File: $input_original_file_path\" with title \"Subtitles converter\" subtitle \"CP1250 to UTF-8\""
else 
    osascript -e "display notification \"File: $input_file_path\" with title \"Subtitles converter\" subtitle \"CP1250 to UTF-8\""
fi