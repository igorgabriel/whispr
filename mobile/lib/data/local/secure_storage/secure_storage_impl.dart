import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage.dart';

class SecureStorageImplementation implements SecureStorage {
  FlutterSecureStorage? storage;
  SecureStorageImplementation() {
    init();
  }

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  @override
  void init() {
    storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  @override
  bool get hasInitialized => storage != null;

  @override
  Future<bool> set(String key, String data) async {
    if (hasInitialized) {
      await storage?.write(key: key, value: data.toString());
      return true;
    }

    return false;
  }

  @override
  Future<Object?> get(String key) async {
    if (hasInitialized) {
      return await storage?.read(key: key);
    }
    return null;
  }

  @override
  Future<bool> has(String key) async {
    if (hasInitialized) {
      return await storage?.containsKey(key: key) ?? false;
    }
    return false;
  }

  @override
  Future<bool> remove(String key) async {
    if (hasInitialized) {
      await storage?.delete(key: key);
      return true;
    }
    return false;
  }

  @override
  Future<void> clear() async {
    if (hasInitialized) {
      await storage?.deleteAll();
    }
  }
}
