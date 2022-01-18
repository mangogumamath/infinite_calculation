import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

//광고 사이즈
// final AdSize adSize = AdSize(width: 300, height: 50);

//광고 ID
//배너 아이디
String adUnitIdBanner = 'ca-app-pub-3940256099942544/6300978111';
// ca-app-pub-7290364920511331/5559853443
//'ca-app-pub-3940256099942544/6300978111'; // 테스트용

//전면 아이디
String adUnitIdInterstitial = 'ca-app-pub-3940256099942544/1033173712';
// ca-app-pub-7290364920511331/7886919299
//'ca-app-pub-3940256099942544/1033173712'; // 테스트용
//'ca-app-pub-3940256099942544/8691691433'; // 테스트용 동영상

class AdMob {
  late BannerAd myBanner;

  late AdWidget adWidget;
  late Container adContainer;
  late InterstitialAd _interstitialAd;

  AdMob() {
    myBanner = BannerAd(
      adUnitId: adUnitIdBanner,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    adWidget = AdWidget(ad: myBanner);
    adContainer = Container(
      alignment: Alignment.center,
      child: adWidget,
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
  }

  void showInterstitialAd() {
    InterstitialAd.load(
        adUnitId: adUnitIdInterstitial,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
            _interstitialAd.show();

            _interstitialAd.fullScreenContentCallback =
                FullScreenContentCallback(
              onAdShowedFullScreenContent: (InterstitialAd ad) =>
                  print('$ad onAdShowedFullScreenContent.'),
              onAdDismissedFullScreenContent: (InterstitialAd ad) {
                print('$ad onAdDismissedFullScreenContent.');
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent:
                  (InterstitialAd ad, AdError error) {
                print('$ad onAdFailedToShowFullScreenContent: $error');
                ad.dispose();
              },
              onAdImpression: (InterstitialAd ad) =>
                  print('$ad impression occurred.'),
            );
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  // final BannerAdListener listener = BannerAdListener(
  //   // Called when an ad is successfully received.
  //   onAdLoaded: (Ad ad) => print('Ad loaded.'),
  //   // Called when an ad request failed.
  //   onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //     // Dispose the ad here to free resources.
  //     ad.dispose();
  //     print('Ad failed to load: $error');
  //   },
  //   // Called when an ad opens an overlay that covers the screen.
  //   onAdOpened: (Ad ad) => print('Ad opened.'),
  //   // Called when an ad removes an overlay that covers the screen.
  //   onAdClosed: (Ad ad) => print('Ad closed.'),
  //   // Called when an impression occurs on the ad.
  //   onAdImpression: (Ad ad) => print('Ad impression.'),
  // );
}
