#!/usr/bin/env bash
# Check ~/dots and /etc/nixos for unpulled upstream changes and notify.
set -u

NOTIFY="${NOTIFY:-notify-send}"
FETCH_TIMEOUT=30
REPOS=("$HOME/dots" "/etc/nixos")

notify() {
    if command -v "$NOTIFY" >/dev/null 2>&1; then
        "$NOTIFY" -u normal -a "upstream-check" "$1" "$2"
    else
        echo "notify-send not found: $1: $2" >&2
    fi
}

declare -a CHANGED=()

for repo in "${REPOS[@]}"; do
    if [[ ! -d "$repo/.git" ]]; then
        echo "skipping $repo: not a git repo" >&2
        continue
    fi

    if ! git -C "$repo" fetch --quiet --prune origin 2>/dev/null; then
        echo "warning: fetch failed for $repo (offline? auth issue?)" >&2
        continue
    fi

    branch="$(git -C "$repo" rev-parse --abbrev-ref HEAD 2>/dev/null)"
    if [[ -z "$branch" || "$branch" == "HEAD" ]]; then
        echo "skipping $repo: detached HEAD" >&2
        continue
    fi

    if ! upstream="$(git -C "$repo" rev-parse --abbrev-ref '@{u}' 2>/dev/null)"; then
        echo "skipping $repo: branch '$branch' has no upstream" >&2
        continue
    fi

    behind="$(git -C "$repo" rev-list --count "HEAD..$upstream" 2>/dev/null)"
    if [[ -n "$behind" && "$behind" -gt 0 ]]; then
        echo "$repo is $behind commit(s) behind $upstream"
        CHANGED+=("$repo ($behind new commit(s) on $upstream)")
    else
        echo "$repo is up to date with $upstream"
    fi
done

if [[ ${#CHANGED[@]} -gt 0 ]]; then
    body="$(printf '%s\n' "${CHANGED[@]}")"
    notify "Upstream updates available in ${#CHANGED[@]} repo(s)" "$body"
fi
