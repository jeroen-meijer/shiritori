#!/bin/bash

set -e

pushd app
flutter pub run intl_translation:generate_from_arb --output-dir=lib/intl/messages/ --no-use-deferred-loading lib/intl/localizations.dart lib/intl/arb/intl_*.arb
popd