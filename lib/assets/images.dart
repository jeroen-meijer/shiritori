import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum _ImageType {
  bitmap,
  vector,
}

@immutable
class Images extends Equatable {
  const Images._bitmap(String resource)
      : path = '$_basePath/png/$resource.png',
        type = _ImageType.bitmap;

  // Will be used later.
  // ignore: unused_element
  const Images._vector(String resource)
      : path = '$_basePath/svg/$resource.svg',
        type = _ImageType.vector;

  final String path;
  final _ImageType type;

  static const _basePath = 'assets/images';

  // Bitmap assets
  static const backgroundMain = Images._bitmap('background_main');

  /// Produces a widget that displays the associated asset.
  _ImageAssetView call({
    Key key,
    double width,
    double height,
    Alignment alignment = Alignment.center,
    BoxFit fit = BoxFit.contain,
    Color color,
  }) {
    return _ImageAssetView(
      this,
      width: width,
      height: height,
      alignment: alignment,
      fit: fit,
      color: color,
    );
  }

  @override
  List<Object> get props => [
        path,
        type,
      ];
}

class _ImageAssetView extends StatelessWidget {
  const _ImageAssetView(
    this.asset, {
    Key key,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  final Images asset;
  final double width;
  final double height;
  final Alignment alignment;
  final BoxFit fit;
  final Color color;

  @override
  Widget build(BuildContext context) {
    switch (asset.type) {
      case _ImageType.bitmap:
        return Image.asset(
          asset.path,
          width: width,
          height: height,
          alignment: alignment,
          fit: fit,
          color: color,
        );
      case _ImageType.vector:
      default:
        return SvgPicture.asset(
          asset.path,
          width: width,
          height: height,
          alignment: alignment,
          fit: fit,
          color: color,
        );
    }
  }
}
