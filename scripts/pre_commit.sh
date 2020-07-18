#!/bin/sh
set -e

echo 'Running flutter analyze...'
flutter analyze
echo 'Running flutter format...'
flutter format --line-length 80 --set-exit-if-changed .
echo 'Extracting intl ARBs...'
flutter pub run intl_translation:extract_to_arb --suppress-last-modified --output-dir=lib/intl/arb lib/intl/strings/*.dart

echo ''
echo 'Done.'
echo ''

if [ -z "$(git status --porcelain)" ]; then
  echo 'Working directory clean.'
  exit 0
else
  echo '! Uncommitted changes detected. Please push the new changes to this branch.'
  exit 1
fi