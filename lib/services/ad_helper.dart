import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static final Map<String, InterstitialAd> _interstitialAds = {};

  static void initializeInterstitialAd({
    required String adUnitId,
    Function? onDone,
  }) {
    if (_interstitialAds.containsKey(adUnitId)) {
      return;
    }

    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          // Keep a reference to the ad so you can show it later.
          _interstitialAds[adUnitId] = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );

    if (onDone != null) {
      onDone();
    }
  }

  static void showInterstitialAd(String adUnitId, Function onAdClosed) {
    if (_interstitialAds.containsKey(adUnitId)) {
      _interstitialAds[adUnitId]!.fullScreenContentCallback =
          FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          debugPrint('showInterstitialAd: $ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          debugPrint('showInterstitialAd: $ad onAdDismissedFullScreenContent.');
          ad.dispose();
          onAdClosed();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          debugPrint(
            'showInterstitialAd: $ad onAdFailedToShowFullScreenContent: $error',
          );
          ad.dispose();
          onAdClosed();
        },
        onAdImpression: (InterstitialAd ad) {
          debugPrint('showInterstitialAd: $ad impression occurred.');
        },
      );

      _interstitialAds[adUnitId]!.show();
      _interstitialAds.remove(adUnitId);
    } else {
      initializeInterstitialAd(adUnitId: adUnitId, onDone: onAdClosed);
    }
  }

  static String get loadingOneBannerAd {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-1247985751357725/2465072776';

      // test id
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return '////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get loadingTwoBannerAd {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-1247985751357725/2245580923';

      // test id
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return '/////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get viewVenueBannerAd {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-1247985751357725/8543982699';

      // test id
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return '/////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get viewVenueInterstitialAd {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-1247985751357725/9792651035';

      // test id
      return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return '////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }
}
