#!/bin/bash
msg= 
if [ ! $1 ]; then
    echo "msg"
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

