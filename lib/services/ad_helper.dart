import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//https://developers.google.com/admob/android/test-ads#sample_ad_units

class AdHelper {
  static final Map<String, InterstitialAd> _interstitialAds = {};
  static final Map<String, RewardedAd> _rewardedAds = {};

  static String get loadingOneBannerAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1247985751357725/2465072776';

      // test id
      // return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return '////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get loadingTwoBannerAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1247985751357725/2245580923';

      // test id
      // return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return '/////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get viewVenueBannerAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1247985751357725/8543982699';

      // test id
      // return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return '/////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get viewVenueInterstitialAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1247985751357725/9792651035';

      // test id
      // return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return '////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get joinOrCreateRoomInterstitialAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1247985751357725/8906836970';

      // test id
      // return 'ca-app-pub-3940256099942544/1033173712';
    } else if (Platform.isIOS) {
      return '////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get getMoreTokensRewardedAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1247985751357725/7337430971';

      // test id
      // return 'ca-app-pub-3940256099942544/5224354917';
    } else if (Platform.isIOS) {
      return '////ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static void initializeRewardedAd({
    required String adUnitId,
    Function? onDone,
  }) {
    if (_rewardedAds.containsKey(adUnitId)) {
      return;
    }

    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (RewardedAd ad) {
          _rewardedAds[adUnitId] = ad;
          if (onDone != null) {
            onDone();
          }
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  static void showRewardedAd({
    required String adUnitId,
    required String userId,
    required String token,
    required Function onUserEarnedReward,
  }) {
    if (_rewardedAds.containsKey(adUnitId)) {
      _rewardedAds[adUnitId]!.setServerSideOptions(
        ServerSideVerificationOptions(
          userId: userId,
          customData: token,
        ),
      );

      _rewardedAds[adUnitId]!.fullScreenContentCallback =
          FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) {
          debugPrint('showRewardedAd: $ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          debugPrint('showRewardedAd: $ad onAdDismissedFullScreenContent.');
          ad.dispose();
          _rewardedAds.remove(adUnitId);
          initializeRewardedAd(adUnitId: adUnitId);
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          debugPrint(
            'showRewardedAd: $ad onAdFailedToShowFullScreenContent: $error',
          );
          ad.dispose();
          _rewardedAds.remove(adUnitId);
          initializeRewardedAd(adUnitId: adUnitId);
        },
        onAdImpression: (RewardedAd ad) {
          debugPrint('showRewardedAd: $ad impression occurred.');
        },
      );

      _rewardedAds[adUnitId]!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          onUserEarnedReward();
        },
      );

      _rewardedAds.remove(adUnitId);
      initializeRewardedAd(adUnitId: adUnitId);
    } else {
      initializeRewardedAd(
        adUnitId: adUnitId,
        onDone: () {
          showRewardedAd(
            adUnitId: adUnitId,
            userId: userId,
            token: token,
            onUserEarnedReward: onUserEarnedReward,
          );
        },
      );
    }
  }

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
      initializeInterstitialAd(adUnitId: adUnitId);
    } else {
      initializeInterstitialAd(adUnitId: adUnitId, onDone: onAdClosed);
    }
  }
}
