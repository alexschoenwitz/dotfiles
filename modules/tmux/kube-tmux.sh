#!/usr/bin/env bash
KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"
CACHE_FILE="/tmp/kube-tmux-cache"
CACHE_TIME="/tmp/kube-tmux-time"

[[ -f "$KUBECONFIG" ]] || exit 0

if [[ "$(uname)" == "Darwin" ]]; then
  mtime=$(stat -f %m "$KUBECONFIG" 2>/dev/null)
else
  mtime=$(stat -c %Y "$KUBECONFIG" 2>/dev/null)
fi

cached_time=$(cat "$CACHE_TIME" 2>/dev/null)
if [[ "$mtime" == "$cached_time" && -f "$CACHE_FILE" ]]; then
  cat "$CACHE_FILE"
  exit 0
fi

ctx=$(kubectl config current-context 2>/dev/null)
[[ -z "$ctx" ]] && exit 0
ns=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
ns="${ns:-default}"

result="⎈ ${ctx}:${ns}"
echo "$result" > "$CACHE_FILE"
echo "$mtime" > "$CACHE_TIME"
echo "$result"
