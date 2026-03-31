#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="$REPO_ROOT/scripts/launchd/com.yibie.awesome-autoresearch-updater.plist.template"
TARGET_DIR="$HOME/Library/LaunchAgents"
TARGET_PLIST="$TARGET_DIR/com.yibie.awesome-autoresearch-updater.plist"
ENV_FILE_DEFAULT="$REPO_ROOT/scripts/update-awesome-autoresearch.env"
ENV_FILE="${ENV_FILE:-$ENV_FILE_DEFAULT}"
SCRIPT_PATH="$REPO_ROOT/scripts/update-awesome-autoresearch.sh"
LOG_DIR="$REPO_ROOT/.logs"
STDOUT_LOG="$LOG_DIR/launchd.stdout.log"
STDERR_LOG="$LOG_DIR/launchd.stderr.log"

mkdir -p "$TARGET_DIR" "$LOG_DIR"
[ -f "$TEMPLATE" ] || { echo "template not found: $TEMPLATE" >&2; exit 1; }
[ -x "$SCRIPT_PATH" ] || chmod +x "$SCRIPT_PATH"

PI_BIN_CURRENT="$(command -v pi)"
NODE_BIN_CURRENT="$(command -v node)"
PI_CLI_JS_CURRENT="$(python - "$PI_BIN_CURRENT" <<'PY'
import os, sys
print(os.path.realpath(sys.argv[1]))
PY
)"
NODE_BIN_REAL="$(python - "$NODE_BIN_CURRENT" <<'PY'
import os, sys
print(os.path.realpath(sys.argv[1]))
PY
)"
LAUNCHCTL_BIN="${LAUNCHCTL_BIN:-$(command -v launchctl)}"
[ -x "$LAUNCHCTL_BIN" ] || { echo "launchctl not found" >&2; exit 1; }

ESCAPE() {
  printf '%s' "$1" | sed -e 's/[\\&]/\\\\&/g'
}

PATH_VALUE="${PATH:-/usr/bin:/bin:/usr/sbin:/sbin}"

cp "$TEMPLATE" "$TARGET_PLIST"
sed -i '' \
  -e "s|__SCRIPT_PATH__|$(ESCAPE "$SCRIPT_PATH")|g" \
  -e "s|__REPO_ROOT__|$(ESCAPE "$REPO_ROOT")|g" \
  -e "s|__PATH__|$(ESCAPE "$PATH_VALUE")|g" \
  -e "s|__ENV_FILE__|$(ESCAPE "$ENV_FILE")|g" \
  -e "s|__PI_BIN__|$(ESCAPE "$PI_BIN_CURRENT")|g" \
  -e "s|__NODE_BIN__|$(ESCAPE "$NODE_BIN_REAL")|g" \
  -e "s|__PI_CLI_JS__|$(ESCAPE "$PI_CLI_JS_CURRENT")|g" \
  -e "s|__STDOUT_LOG__|$(ESCAPE "$STDOUT_LOG")|g" \
  -e "s|__STDERR_LOG__|$(ESCAPE "$STDERR_LOG")|g" \
  "$TARGET_PLIST"

if "$LAUNCHCTL_BIN" print "gui/$(id -u)/com.yibie.awesome-autoresearch-updater" >/dev/null 2>&1; then
  "$LAUNCHCTL_BIN" bootout "gui/$(id -u)" "$TARGET_PLIST" >/dev/null 2>&1 || true
fi

"$LAUNCHCTL_BIN" bootstrap "gui/$(id -u)" "$TARGET_PLIST"
"$LAUNCHCTL_BIN" enable "gui/$(id -u)/com.yibie.awesome-autoresearch-updater"

echo "Installed launchd job: $TARGET_PLIST"
echo "Interval: every 21600 seconds (6 hours)"
echo "Env file: $ENV_FILE"
echo "Logs: $STDOUT_LOG / $STDERR_LOG"
echo "Test now: $LAUNCHCTL_BIN kickstart -k gui/$(id -u)/com.yibie.awesome-autoresearch-updater"
