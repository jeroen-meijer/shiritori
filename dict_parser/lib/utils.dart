import 'package:xml/xml.dart';

extension XmlElementsX on Iterable<XmlElement> {
  Iterable<String> mapEachToText() {
    return map((element) => element.text);
  }
}

extension XmlElementX on XmlElement {
  Iterable<XmlElement> findAllElementsDeep(Iterable<String> path) {
    final allElements = findAllElements(path.first);
    if (path.length == 1) {
      return allElements;
    }

    return allElements
        .map((element) => element.findAllElementsDeep(path.skip(1)))
        .expand((e) => e);
  }
}