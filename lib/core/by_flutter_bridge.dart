import 'package:flutter/services.dart';

class ByFlutterBridge {
  static ByFlutterBridge _instance = ByFlutterBridge._();
  MethodChannel _bridge = const MethodChannel("ByFlutterBridge");//名字与Native端保持一致
  //存储监听来自Native消息的监听器
  var _listeners = {};
  ByFlutterBridge._() {
    _bridge.setMethodCallHandler((MethodCall call) {
      String method = call.method;
      if (_listeners[method] != null) {
        return _listeners[method](call);
      }
      return null;
    });
  }

  static ByFlutterBridge getInstance() {
    return _instance;
  }

  register(String method, Function(MethodCall)callBack) {
    _listeners[method] = callBack;
  }

  unRegister(String method) {
    _listeners.remove(method);
  }

  goToNative(Map params) {
    _bridge.invokeMethod("goToNative", params);
  }

  MethodChannel bridge() {
    return _bridge;
  }
}