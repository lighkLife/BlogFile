 #!/bin/bash
msg= 
if [ ! -n "$1"]; then
    echo "-"
else
    msg= $1
fi
cd lighklife
hexo clean
hexo g
hexo d
cd ..
git add --all
git commit -m msg
git push

