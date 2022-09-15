

class AdHelper {
  static const bool _testMode = false;

  static String get bannerAdUnitId {
    if (_testMode) {
      return 'ee669f08-12fe-4ee5-a521-dd5904fbcce5';
    }
    
    return 'ca-app-pub-8887736687313297/2361886259';
  }
  static String get viewAd {
    if (_testMode) {
      return 'ee669f08-12fe-4ee5-a521-dd5904fbcce5';
    }
    
    return 'ca-app-pub-8887736687313297/3098013737';
  }
}
