git add .
echo "Enter comment:"
read comment
git commit -m "$comment"
echo "Do you want to change branch? (y/n)"
read res

if [[ "$res" == [yY] ]]; then
    echo "Enter branch name:"
    read branch
    git checkout -b "$branch"
elif [[ "$res" == [nN] ]]; then
    git push
else
    echo "Error encountered"
fi
