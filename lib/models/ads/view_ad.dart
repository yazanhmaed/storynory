import 'dart:ffi';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:storynory/models/ads/ad_helper.dart';

class AdInterstitialView {
  static InterstitialAd? _interstitialAd;
  static bool isAdReady = false;

  static Void? loadinterstitalAd() {
     InterstitialAd.load(
      adUnitId: AdHelper.viewAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          isAdReady = true;
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {},
      ),
    );
    _interstitialAd?.show();
    return null;
  }

  static Void? showInterstitialAd() {
    if (isAdReady) {
      _interstitialAd?.show();
    }
    return null;
  }
}
