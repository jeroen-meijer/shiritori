#!/bin/bash

set -e

flutter pub run intl_translation:extract_to_arb --suppress-last-modified --output-dir=lib/intl/arb lib/intl/strings/*.dart

if [ -z "$(git status --porcelain)" ]; then
  exit 0
else
  echo "Latest intl ARBs have not been pushed."
  echo "Run this script locally and push it to this branch."
  echo "  ./scripts/$(basename $0)"
  exit 1
fi

if [ "$(git diff --exit-code)" ]; then
 
else
  exit 0
fi
