#!/usr/bin/env bash
# Install git hooks from the hooks directory

set -e

HOOKS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GIT_DIR="$(git rev-parse --git-dir)"

echo "Installing git hooks from $HOOKS_DIR to $GIT_DIR/hooks"

# Create hooks directory if it doesn't exist
mkdir -p "$GIT_DIR/hooks"

# Link all hook files
for hook in "$HOOKS_DIR"/*; do
	hook_name=$(basename "$hook")

	# Skip the install script itself
	if [ "$hook_name" = "install.sh" ] || [ "$hook_name" = "README.md" ]; then
		continue
	fi

	# Skip if it's a directory
	if [ -d "$hook" ]; then
		continue
	fi

	target="$GIT_DIR/hooks/$hook_name"

	# Create symlink
	ln -sf "$hook" "$target"
	echo "Installed: $hook_name"
done

echo "Git hooks installed successfully!"
