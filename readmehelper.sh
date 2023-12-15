#created-by:ASDTS
# Function to check character count of readme.md
getreadmeCharacterCount() {
    local readmeFile="readme.md"
    local charCount
    if [[ -f "$readmeFile" ]]; then
        charCount=$(wc -c < "$readmeFile")
        echo "$charCount"
    else
        echo "0"
    fi
}

# Function to add link and project details to readme.md
addDetailsToreadme() {
    local link=$1
    local description=$2
    local contributors=$3
    local abouts=$4
    local update=$5

    echo -e "\n$link" >> readme.md
    echo >> readme.md
    echo "## Description" >> readme.md
    echo "$description" >> readme.md
    echo >> readme.md
    echo "## Contributors" >> readme.md
    echo "$contributors" >> readme.md
    echo "## project" >> readme.md
    echo "$abouts" >> readme.md
    echo "## Update" >> readme.md
    echo "$update" >> readme.md

    echo "Details added to readme.md"
}

# Check if readme.md has less than 200 characters
if (( $(getreadmeCharacterCount) < 200 )); then

    # Prompt the user for input until they enter an empty line
    while true; do
        echo "Enter your text (leave blank to finish):"
        read input

        # Break the loop if the user enters an empty line
        [[ -z "$input" ]] && break

        # Function to check if a string contains a URL
        containsURL() {
            local string=$1
            # Regular expression to match a URL
            local urlRegex="https?://[^[:space:]]+"
            if [[ $string =~ $urlRegex ]]; then
                echo "${BASH_REMATCH[0]}"  # Output the matched URL
                return 0  # Return success (URL found)
            else
                return 1  # Return failure (URL not found)
            fi
        }

        # Check if the user input contains a URL
        if containsURL "$input"; then
            # If a URL is found, extract project details from the latest commit
            links+="\n[Click here to visit the link]($input)"
            abouts+="\n$(git log -1 --pretty=%s)"
        else
            # If no URL is found, consider it as a description
            description+="\n$input"
        fi
    done

    contributors=$(git log --format='%aN' | sort -u | while read name; do echo "- $name"; done)

    # Add link and project details to readme.md
    addDetailsToreadme """$links" "$description" "$contributors" "$abouts"
else
    # If readme.md has 200 or more characters, add the latest commit message to the update section
    update+="\n$(git log -1 --pretty=%s)"
    echo "Update section in readme.md:"
    echo "## Update" >> readme.md
    echo "$update" >> readme.md
fi
