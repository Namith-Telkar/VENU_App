import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:venu/services/ad_helper.dart';
import 'package:venu/widgets/show_banner_ad.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ShowBannerAd(adUnitId: AdHelper.loadingOneBannerAd),
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                child: SpinKitThreeBounce(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  size: 40.0,
                ),
              ),
              ShowBannerAd(adUnitId: AdHelper.loadingTwoBannerAd),
            ],
          ),
        ),
      ),
    );
  }
}
