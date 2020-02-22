import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageDisplay extends StatelessWidget {
  final String imageName;
  final String assetPath = 'assets/images/';
  final double width;
  final double height;
  const ImageDisplay(
      {Key key, @required this.imageName, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (width == null && height == null) {
        return  getImage();
      } else if (width == null) {
        return Container(
          width: constraints.maxWidth,
          height: height,
          child: getImage(),
        );
      } else if (height == null) {
        return Container(
          width: width,
          height: constraints.maxHeight,
          child: getImage(),
        );
      } else {
        return Container(
          width: this.width,
          height: this.height,
          child: getImage(),
        );
      }
    });
  }

  Widget getImage() {
    if (imageName.contains(".svg")) {
      return SvgPicture.asset(
        assetPath + imageName,
        semanticsLabel: 'svg img',
      );
    } else {
      return Image.asset(
        assetPath + imageName,
        fit: BoxFit.contain,
      );
    }
  }
}
