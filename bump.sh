#!/usr/bin/env bash
# Point a cask at a new release:  ./bump.sh wisp 0.1.1
# Downloads the asset the cask's url points to, hashes it, and updates `version` and `sha256`.
set -euo pipefail

cask="${1:?usage: ./bump.sh CASK X.Y.Z}"
version="${2:?usage: ./bump.sh CASK X.Y.Z}"
cd "$(dirname "${BASH_SOURCE[0]}")"

file="Casks/${cask}.rb"
[[ -f "${file}" ]] || {
  echo "No such cask: ${file}" >&2
  exit 1
}

template="$(sed -nE 's/^  url "([^"]+)".*/\1/p' "${file}" | head -n 1)"
url="$(printf '%s' "${template}" | sed "s/#{version}/${version}/g")"

tmp="$(mktemp)"
trap 'rm -f "${tmp}"' EXIT
curl -fsSL "${url}" -o "${tmp}"
sha="$(shasum -a 256 "${tmp}" | awk '{print $1}')"

sed -i '' -E "s/^  version \".*\"/  version \"${version}\"/; s/^  sha256 \".*\"/  sha256 \"${sha}\"/" "${file}"
echo "${file} → ${version} (${sha})"
echo "Next: git commit -am \"${cask} ${version}\" && git push"
