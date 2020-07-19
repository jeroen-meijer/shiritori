import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

void main() {
  test('jisho', () async {
    final result = await jisho.scrapeForPhrase('言葉');
    log(result.toString());
  });
}
