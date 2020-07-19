class DictionaryRepositoryException implements Exception {
  const DictionaryRepositoryException._([this.message]);

  final String message;
}

class DictionaryRepositoryWordNotFoundException
    extends DictionaryRepositoryException {
  DictionaryRepositoryWordNotFoundException() : super._('Word not found.');
}
