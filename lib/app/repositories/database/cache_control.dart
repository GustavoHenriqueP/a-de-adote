import 'package:shared_preferences/shared_preferences.dart';

class CacheControl {
  CacheControl._();

  static Future<bool> canUpdateCacheOngs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('lastCacheDateOng');
    String? lastCacheString = sp.getString('lastCacheDateOngs');

    if (lastCacheString == null) {
      await sp.setString('lastCacheDateOngs', DateTime.now().toIso8601String());
      return true;
    }

    DateTime lastCacheDateTime = DateTime.parse(lastCacheString);
    int timeDifference = DateTime.now().difference(lastCacheDateTime).inHours;
    if (timeDifference >= 8) {
      await sp.setString('lastCacheDateOngs', DateTime.now().toIso8601String());
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> canUpdateCachePets() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? lastCacheString = sp.getString('lastCacheDatePets');

    if (lastCacheString == null) {
      await sp.setString('lastCacheDatePets', DateTime.now().toIso8601String());
      return true;
    }

    DateTime lastCacheDateTime = DateTime.parse(lastCacheString);
    int timeDifference = DateTime.now().difference(lastCacheDateTime).inHours;
    if (timeDifference >= 8) {
      await sp.setString('lastCacheDatePets', DateTime.now().toIso8601String());
      return true;
    } else {
      return false;
    }
  }
}
