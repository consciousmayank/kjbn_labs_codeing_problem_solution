import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked_annotations.dart';

abstract class IAppDataService {
  void saveCurrentSecond({required int value});

  void saveRandomNumber({required int value});

  void saveSuccessfulCount({required int value});

  void saveUnSuccessfulCount({required int value});

  void saveTimerSecondsRemaining({required int value});

  int? fetchCurrentSecond();

  int? fetchRandomNumber();

  int fetchSuccessfulCount();

  int fetchTimerSecondsRemaining();

  int fetchUnSuccessfulCount();
}

const String _preferencesEncryptionKey = 'preferencesEncryptionKey';
const String _currentSecondKey = 'currentSecondKey';
const String _randomNumberKey = 'randomNumberKey';
const String _successfulCountKey = 'successfulCountKey';
const String _unSuccessfulCountKey = 'unSuccessfulCountKey';
const String _timerSecondsRemainingKey = 'timerSecondsRemainingKey';

class AppDataService implements IAppDataService, InitializableDependency {
  late List<int> key;

  late Box appHelperBox;

  final FlutterSecureStorage _sharedPrefs = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ));

  Future _initPreferences() async {
    String? keyString = await _sharedPrefs.read(key: _preferencesEncryptionKey);

    if (keyString == null) {
      key = Hive.generateSecureKey();
      await _sharedPrefs.write(
        key: _preferencesEncryptionKey,
        value: base64UrlEncode(
          key,
        ),
      );
    } else {
      key = base64Url.decode(keyString);
    }

    await Hive.initFlutter();
    await _openAppHelperBox();
  }

  Future _openAppHelperBox() async {
    appHelperBox = await Hive.openBox(
      'appHelperBox',
      encryptionCipher: HiveAesCipher(
        key,
      ),
    );
  }

  @override
  Future<void> init() async {
    await _initPreferences();
  }

  @override
  int? fetchCurrentSecond() {
    return appHelperBox.get(_currentSecondKey, defaultValue: null);
  }

  @override
  int? fetchRandomNumber() {
    return appHelperBox.get(_randomNumberKey, defaultValue: null);
  }

  @override
  int fetchSuccessfulCount() {
    return appHelperBox.get(_successfulCountKey, defaultValue: 0);
  }

  @override
  int fetchUnSuccessfulCount() {
    return appHelperBox.get(_unSuccessfulCountKey, defaultValue: 0);
  }

  @override
  void saveCurrentSecond({required int value}) {
    appHelperBox.put(_currentSecondKey, value);
  }

  @override
  void saveRandomNumber({required int value}) {
    appHelperBox.put(_randomNumberKey, value);
  }

  @override
  void saveSuccessfulCount({required int value}) {
    appHelperBox.put(_successfulCountKey, value);
  }

  @override
  void saveUnSuccessfulCount({required int value}) {
    appHelperBox.put(_unSuccessfulCountKey, value);
  }

  @override
  int fetchTimerSecondsRemaining() {
    return appHelperBox.get(_timerSecondsRemainingKey, defaultValue: 0);
  }

  @override
  void saveTimerSecondsRemaining({required int value}) {
    appHelperBox.put(_timerSecondsRemainingKey, value);
  }
}
