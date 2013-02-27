#! /bin/bash
#
# install.sh
#		Installer script for GitFlow / HubFlow

# Usage: [environment] installer.sh [install|uninstall]
# Environment:
#   INSTALL_PREFIX=$INSTALL_PREFIX" (default is /usr/local/bin)

# ensure INSTALL_PREFIX or parent is writable by user
check_write_access() {
	local prefix="$INSTALL_PREFIX"
	while [ ! -d "$prefix" ]; do
		prefix=$(dirname "$prefix")
	done
	if [ ! -w "$prefix" ]; then
		echo "'$prefix' is not writable by $(whoami)"
		if [ `id -u` != 0 ]; then
			echo "Run as install as root (use sudo)"
		fi
		return 1
	fi
	return 0
}

if [ -z "$INSTALL_PREFIX" ]; then INSTALL_PREFIX="/usr/local/bin"; fi
check_write_access || exit 1
export REPO_NAME="`dirname $0`"
bash $REPO_NAME/contrib/gitflow-installer.sh "$@"
