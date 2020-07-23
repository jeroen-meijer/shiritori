#!/bin/sh
set -e

pushd dict_parser
echo "Running pub get..."
pub get
echo "Compiling dict_parser..."
dart2native ./bin/dict_parser.dart -o ./dict_parser
./dict_parser JMdict_e.xml
echo "Moving generated dictionaries..."
mv ./dict_*.json ../app/assets/dicts/.
echo "Done."
popd