#!/usr/bin/env bash
set -e
repo_state=$(git status --porcelain)

# If $repo_state is not empty
if [ -n "$repo_state" ]; then
  echo -e "Repo is dirty, ignoring changes in the following modified/untracked files:\n"
  echo -e "${repo_state}\n"
fi

sha=$(git rev-parse --short master)
pre=$(basename $(pwd))
tmpdir=$(mktemp -d)
zip_name="${pre}-${sha}.zip"

git archive master --prefix="$pre/" | tar -x -C "$tmpdir"
echo "$sha" >> "$tmpdir/$pre/version.txt"
cd "$tmpdir"
zip -rq "$zip_name" "$pre"
rm -r ./"${pre}"/
cd - > /dev/null

mount_path=$(mount | grep ' /tmp ')
# If $repo_state is not empty
if [ -n "$mount_path" ]; then
  real_tmp_path=$( echo "$mount_path" | awk {'print $1'} )
  zip_path="${real_tmp_path}/$(basename "$tmpdir")/${zip_name}"
else
  zip_path="${tmpdir}/${zip_name}"
fi

echo "Archive exported to $zip_path"
