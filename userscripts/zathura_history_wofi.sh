#!/bin/sh
# see https://unix.stackexchange.com/questions/467524/open-file-from-history-in-zathura

# save filepaths in history to array, reverse  order
readarray -t Data < <(sqlite3 ~/.local/share/zathura/bookmarks.sqlite "SELECT file FROM fileinfo WHERE file NOT REGEXP '/tmp/*' ORDER BY time DESC;")

# loop and unset not existing files 
for i in "${!Data[@]}"
do  
    if ! [ -e "${Data[$i]}" ]; then
        # echo "${Data[$i]} does not exist."
        unset 'Data[$i]'
    # else
# Add substitition $HOME with ~ , really slow
        # Data[$i]=$(echo ${Data[$i]} | sed "s#$HOME#~#")
        # Data[$i]=$(echo ${Data[$i]} | sed "s#/mnt/Backup#~#")
        # echo "${Data[$i]} exists."
    fi
done
selected=$( ( IFS=$'\n'; echo "${Data[*]}" ) | wofi -i -d --hide-scroll --allow-markup --prompt='Open Document')


# exit if nothing is selected
[[ -z $selected ]] && exit

# prevent opening not existing file 
if [ -f "$selected" ]; then
    echo "$selected exists."
    zathura "$selected"
else
    echo "$selected does not exist."
    exit
fi

exit 0
