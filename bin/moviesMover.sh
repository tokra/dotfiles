#!/bin/bash
year_to_move=""
input_dir=""
output_dir=""

##### Start

# read params
while :; do
  case "$1" in
    -h|-\?|--help)
        helpmsg
        exit 0
        ;;
    -i|--input_dir) # Input directory
        input_dir="`realpath $2`"
        shift
        ;;
    -o|--output_dir) # Output directory
        output_dir="`realpath $2`"
        shift
        ;;
    -y|--year_to_move) # Year of movies to move
        year_to_move="$2"
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
final_destination="$output_dir/$year_to_move/"
echo -e "\nInput directory             : $input_dir"
echo -e "Output directory            : $output_dir"
echo -e "Year of movies to move      : $year_to_move"
echo -e "Final destination directory : $final_destination"

###
echo -e "\nLooking for movies..."
declare -a found_movies='()'
while IFS=  read -r -d $'\n'; do
    found_movies+=("$REPLY")
done < <(find $input_dir -type d -maxdepth 1 -regex ".*($year_to_move).*")

if [ ${#found_movies[@]} -eq 0 ]; then
    echo -e "\nHaven't found any movie of year: '$year_to_move'\n"
    exit 1
else
    echo -e "\nFound '${#found_movies[@]}' movies in year: $year_to_move"
    for movie in "${found_movies[@]}"
    do
        echo "$movie"
    done

    echo -e "\nMoving year: '$year_to_move' to: '$final_destination' started...\n"
    for movie in "${found_movies[@]}"
    do
        mv -v "$movie" "$final_destination"
    done
    echo -e "\nMoving of movies done...\n"
    exit 0
fi