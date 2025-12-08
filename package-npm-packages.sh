#!/usr/bin/env bash
set -e

ls -la
cd npm
ls -la

mkdir ${GITHUB_WORKSPACE}/dist
npm pack --workspaces --pack-destination=${GITHUB_WORKSPACE}/dist

ls -la ${GITHUB_WORKSPACE}/dist
pwd

npm pack --pack-destination=${GITHUB_WORKSPACE}/dist

echo "Files before renaming:"
ls -la ${GITHUB_WORKSPACE}/dist

echo ""
echo "Renaming files (removing 'img-' prefix and changing .tgz to .tar.gz)..."
for file in ${GITHUB_WORKSPACE}/dist/img-*.tgz; do
  newname=$(basename "$file" .tgz | sed 's/^img-//').tar.gz
  echo "  $(basename "$file") → $newname"
  mv "$file" "${GITHUB_WORKSPACE}/dist/$newname"
done

echo ""
echo "Files after renaming:"
ls -la ${GITHUB_WORKSPACE}/dist

