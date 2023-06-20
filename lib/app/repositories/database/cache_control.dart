import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db_firestore.dart';

class CacheControl {
  static int _maximumTime = 4;

  static Future<void> initializingCacheControl() async {
    try {
      final snapshot = await DbFirestore.instance
          .collection('variaveis')
          .get(const GetOptions(source: Source.server));
      if (snapshot.docs.isNotEmpty) {
        int? maximumTimeCache = snapshot.docs.first.data()['maximumTimeCache'];
        _maximumTime = maximumTimeCache ?? 8;
      } else {
        _maximumTime = 8;
      }
    } on FirebaseException catch (_) {
      _maximumTime = 8;
    }
  }

  Future<bool> canUpdateCacheOngs() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? lastCacheString = sp.getString('lastCacheDateOngs');

    if (lastCacheString == null) {
      await sp.setString('lastCacheDateOngs', DateTime.now().toIso8601String());
      return true;
    }

    DateTime lastCacheDateTime = DateTime.parse(lastCacheString);
    int timeDifference = DateTime.now().difference(lastCacheDateTime).inHours;
    if (timeDifference >= _maximumTime) {
      await sp.setString('lastCacheDateOngs', DateTime.now().toIso8601String());
      return true;
    } else {
      return false;
    }
  }

  Future<bool> canUpdateCachePets() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? lastCacheString = sp.getString('lastCacheDatePets');

    if (lastCacheString == null) {
      await sp.setString('lastCacheDatePets', DateTime.now().toIso8601String());
      return true;
    }

    DateTime lastCacheDateTime = DateTime.parse(lastCacheString);
    int timeDifference = DateTime.now().difference(lastCacheDateTime).inHours;

    if (timeDifference >= _maximumTime) {
      await sp.setString('lastCacheDatePets', DateTime.now().toIso8601String());
      return true;
    } else {
      return false;
    }
  }
}
