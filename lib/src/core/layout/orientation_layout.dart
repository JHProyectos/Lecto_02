import 'package:flutter/material.dart';

class OrientationLayout extends StatelessWidget {
  final Widget Function(BuildContext, BoxConstraints) portraitLayout;
  final Widget Function(BuildContext, BoxConstraints) landscapeLayout;

  const OrientationLayout({
    Key? key,
    required this.portraitLayout,
    required this.landscapeLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return orientation == Orientation.portrait
                ? portraitLayout(context, constraints)
                : landscapeLayout(context, constraints);
          },
        );
      },
    );
  }
}
