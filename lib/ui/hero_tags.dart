typedef HeroTagGenerator<T> = String Function(T arg);

class HeroTags {
  const HeroTags._();

  // ignore_for_file: prefer_function_declarations_over_variables
  // static HeroTagGenerator<T> heroTag1 = (arg) {
  //   return 'hero-tag-1-$arg';
  // };

  static const quickPlayHeader = 'hero-quick-play-header';
}
