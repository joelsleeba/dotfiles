#/bin/bash
cd /home/joel/workspace/NotesHome

git pull

gstatus=$(git status --porcelain)

if [ ${#gstatus} -ne 0 ]; then
	git add --all
	git commit -m "$gstatus"
	git push
fi
