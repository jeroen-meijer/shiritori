#!/bin/sh

pre_commit_flutter() {
  echo "\nRunning pre-commit script for Flutter in $1\n"
  pushd $1
  echo "Running flutter analyze..."
  flutter analyze
  echo "Running flutter format..."
  flutter format --line-length 80 --set-exit-if-changed .
  echo "Extracting intl ARBs..."
  flutter pub run intl_translation:extract_to_arb --suppress-last-modified --output-dir=lib/intl/arb lib/intl/strings/*.dart
  popd
  echo "\nDone\n"
}

pre_commit_dart() {
  echo "\nRunning pre-commit script for Dart in $1\n"
  pushd $1
  echo "Running dartfmt..."
  dartfmt -w .
  echo "Running dartanalyzer..."
  dartanalyzer --fatal-infos --fatal-warnings lib
  popd
  echo "\nDone\n"
}

pre_commit_flutter "app"
pre_commit_dart "dict_parser"
pre_commit_dart "shared_models"

if [ -z "$(git status --porcelain)" ]; then
  echo "Working directory clean."
  exit 0
else
  echo "! Uncommitted changes detected. Please push the new changes to this branch."
  exit 1
fi
