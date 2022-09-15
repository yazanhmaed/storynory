import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:storynory/models/ads/ad_helper.dart';

class AdBannerModels extends StatefulWidget {
  const AdBannerModels({Key? key}) : super(key: key);

  @override
  State<AdBannerModels> createState() => _AdBannerModelsState();
}

class _AdBannerModelsState extends State<AdBannerModels> {
  late BannerAd bannerAd;
  bool _isAdReady = false;
  final AdSize _adSize = AdSize.fullBanner;

  void _createBannerAd() {
    bannerAd = BannerAd(
        size: _adSize,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            _isAdReady = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          log('ad failed to load : ${error.message}');
        }),
        request: const AdRequest());
    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isAdReady) {
      return SizedBox(
        width: _adSize.width.toDouble(),
        height: _adSize.height.toDouble(),
        child: AdWidget(ad: bannerAd),
        // alignment: Alignment.center,
      );
    }
    return Container();
  }
}
