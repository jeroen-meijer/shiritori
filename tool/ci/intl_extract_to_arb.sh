#!/bin/bash

set -e

pushd app

flutter pub run intl_translation:extract_to_arb --suppress-last-modified --output-dir=lib/intl/arb lib/intl/strings/*.dart

popd

if [ -z "$(git status --porcelain)" ]; then
  exit 0
else
  echo "Latest intl ARBs have not been pushed."
  echo "Run the pre_commit script locally and push to this branch."
  echo "  ./tool/pre_commit.sh"
  exit 1
fi
