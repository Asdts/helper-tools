# Check if the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    # If not, initialize a new Git repository
    git init
    git add README.md
    echo "Git repository initialized."
fi

# Check if a remote named "origin" exists
if ! git remote get-url origin &>/dev/null; then
    # If not, ask for the remote URL and add it as "origin"
    echo "Enter the remote URL:"
    read remote_url
    git remote add origin "$remote_url"
    git branch -M main
    echo "Remote 'origin' added with URL: $remote_url"
fi

# Set the default branch to 'main'
git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main


# Adds all element
git add .
# Commit proccess
echo "Enter comment:"
read comment
git commit -m "$comment"
echo "Do you want to change branch? (y/n)"
read res

# Asking for branch creation
if [[ "$res" == [yY] ]]; then
    #creating branch if answer is y
    echo "Enter branch name:"
    read branch
    git checkout -b "$branch"
    git push -u origin "$branch"
elif [[ "$res" == [nN] ]]; then
    #pushing to main if answer is no
    git push -u origin main
else
    #error messAGE if something else is answer
    echo "Error encountered"
fi
