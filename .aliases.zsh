alias g='git'
alias pm='podman'
alias config='/usr/bin/git --git-dir=~/.cfg/.git/ --work-tree=~/'
alias tf='terraform'
# hack xargs to read aliases
alias xargs='xargs '

function deleteMergedBranch() {
    git pull
    if [ -z "$(git diff head origin/main)" ]; then
        branch=$(git symbolic-ref --short HEAD)
        git checkout main
        git pull --prune
        git checkout $branch
        git reset main
        git checkout main
        git branch $branch -d
    else
        echo "Aborting! There will be uncommitted changes!"
    fi
}

function deleteBranches() {
    git branch | grep $1 | xargs git branch -d
}

function pruneLocalBranches() {
    for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do
        git branch -D $branch
    done
}

function exportDotEnv() {
    set -a
    envFile="${1:-.env}"
    if [ -f "$envFile" ]; then
        source $envFile
    else
        echo ".env file at '$envFile' not found" >&2
    fi
    set +a
}

function md2docx() {
    find . -name "*.md" |
        while read -r f; do
            pandoc "$f" -o "${f%.md}.docx"
        done
}
