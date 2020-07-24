enum GuessValidity {
  valid,
  doesNotFollowPattern,
  invalidWord,
  alreadyGuessed,
  doesNotExist,
}

extension GuessValidityUtils on GuessValidity {
  bool get isValid => this == GuessValidity.valid;
  bool get isInvalid => !isValid;
}
