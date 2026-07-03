#!/bin/sh
input=$(cat)

raw_cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // empty')
home=$(eval echo ~)
cwd="${raw_cwd/#$home/~}"
model=$(echo "$input" | jq -r '.model.display_name // empty')
repo=$(echo "$input" | jq -r '.workspace.repo | if . then .owner + "/" + .name else empty end')
branch=$(echo "$input" | jq -r '.worktree.branch // empty')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Build git info: prefer repo owner/name, fall back to branch, then local git
git_info=""
if [ -n "$repo" ]; then
    git_info="$repo"
elif [ -n "$branch" ]; then
    git_info="$branch"
fi
# Try to get local branch via git if nothing found from JSON
if [ -z "$git_info" ] && [ -n "$raw_cwd" ]; then
    local_branch=$(git -C "$raw_cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
    if [ -n "$local_branch" ]; then
        git_info="$local_branch"
    fi
fi

# Build output
out=""

if [ -n "$cwd" ]; then
    out=" $cwd"
fi

if [ -n "$git_info" ]; then
    out="$out |  $git_info"
fi

if [ -n "$model" ]; then
    out="$out | $model"
fi

if [ -n "$used" ]; then
    out="$out |  ctx: $(printf '%.0f' "$used")% used"
fi

echo "$out"
