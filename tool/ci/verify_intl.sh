#!/bin/bash

set -e

pushd app

echo 'Generating intl from ARBs...'
flutter pub run intl_translation:generate_from_arb --output-dir=lib/intl/messages/ --no-use-deferred-loading lib/intl/localizations.dart lib/intl/arb/intl_*.arb
echo 'Extracting ARBs from intl...'
flutter pub run intl_translation:extract_to_arb --suppress-last-modified --output-dir=lib/intl/arb lib/intl/strings/*.dart
echo 'Formatting...'
flutter format --line-length 80 .

popd

if [ -z "$(git status --porcelain)" ]; then
  exit 0
else
  echo "Latest intl ARBs have not been pushed."
  echo "Run the pre_commit script locally and push to this branch."
  echo "  ./tool/pre_commit.sh"
  exit 1
fi
