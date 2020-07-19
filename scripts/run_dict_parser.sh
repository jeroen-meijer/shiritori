#!/bin/sh
set -e

pushd dict_parser
pub get
dart2native ./bin/dict_parser.dart -o ./dict_parser
./dict_parser JMdict_e.xml
popd