#/bin/bash
cd /home/joel/NotesHome

git pull

gstatus=$(git status --porcelain)

if [ ${#gstatus} -ne 0 ]; then
  git add --all
  git commit -m "$gstatus"
  git push
fi

rclone sync ~/Books/Research papis_gdrive:Supernote/Document/Research\ Articles
rclone sync ~/Books/Mathematics papis_gdrive:Supernote/Document/Books/Mathematics
rclone sync ~/Books/PopBooks papis_gdrive:Supernote/Document/Books/PopBooks
rclone sync ~/Books/Comics papis_gdrive:Supernote/Document/Books/Comics
rclone sync ~/NotesHome/Mathematics/teaching papis_gdrive:Supernote/Note/Teaching
