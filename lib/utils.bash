#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/dathere/qsv"
TOOL_NAME="qsv"
TOOL_TEST="qsv --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if qsv is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3-
}

list_all_versions() {
	list_github_tags
}

download_release() {
	local version filename url remote_filename
	version="$1"
	filename="$2"

	remote_filename="${TOOL_NAME}-${version}-$(arch_and_os).zip"
	url="$GH_REPO/releases/download/${version}/${remote_filename}"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

arch_and_os() {
	local os
	os=$(uname -s | tr '[:upper:]' '[:lower:]')
	arch=$(uname -m)

	if [ "$os" == "darwin" ] && [ "$arch" == "arm64" ]; then
		echo "aarch64-apple-darwin"
	elif [ "$os" == "darwin" ] && [ "$arch" == "x86_64" ]; then
		echo "x86_64-apple-darwin"
	elif [ "$os" == "linux" ] && [ "$arch" == "aarch64" ]; then
		echo "aarch64-unknown-linux-gnu"
	elif [ "$os" == "linux" ] && [ "$arch" == "x86_64" ]; then
		echo "x86_64-unknown-linux-gnu"
	else
		fail "Unsupported platform $os-$arch"
	fi
}
