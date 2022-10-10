import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utilities/constants.dart';

class LoadingTransparentDialog extends StatelessWidget {
  const LoadingTransparentDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: const Center(
          child: SpinKitThreeBounce(
            color: Color(0xffA7D1D7),
            size: 40.0,
          ),
        ),
    );
  }
}
