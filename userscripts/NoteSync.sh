#/bin/bash
cd /home/joel/NotesHome

git pull

gstatus=$(git status --porcelain)

if [ ${#gstatus} -ne 0 ]; then
  git add --all
  git commit -m "$gstatus"
  git push
fi

rclone sync ~/Books/Research papis_gdrive:Supernote/Document/Research\ Articles --exclude "**.mark" --exclude "**.note"
rclone sync ~/Books/Mathematics papis_gdrive:Supernote/Document/Books/Mathematics --exclude "**.mark" --exclude "**.note"
rclone sync ~/Books/PopBooks papis_gdrive:Supernote/Document/Books/PopBooks --exclude "**.mark" --exclude "**.note"
rclone sync ~/Books/Comics papis_gdrive:Supernote/Document/Books/Comics --exclude "**.mark" --exclude "**.note"
rclone sync ~/NotesHome/Mathematics/teaching papis_gdrive:Supernote/Note/Teaching --exclude "**.mark" --exclude "**.note"
rclone sync ~/NotesHome/Mathematics/courses/2026Fall/ papis_gdrive:Supernote/Note/Courses/Fall26 --exclude "**.mark" --exclude "**.note"
