import 'package:flutter/foundation.dart';
import 'package:flutter_weather/app/config/app_constants.dart';

mixin AppLogger {
  final _isDebugMode = AppConstants.isDebugMode;
  var _isLoggerInitialized = false;

  // Códigos de escape ANSI
  static const String _reset = '\x1B[0m';
  static const String _green = '\x1B[32m';
  // static const String _red = '\x1B[31m';
  // static const String _yellow = '\x1B[33m';

  void _initLoggger() {
    _defineDebugPrint();
    _isLoggerInitialized = true;
  }

  void logd(String message) {
    if (!_isLoggerInitialized) {
      _initLoggger();
    }
    debugPrint(_formatMessage(message, color: _green));
  }

  void _defineDebugPrint() {
    // Se não estiver no modo debug, suprime as mensagens de debug.
    if (!kDebugMode && !_isDebugMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  String _formatMessage(String? message, {String? color}) {
    // Formata a mensagem com o nome do app e a data/hora atual
    return "$color[${AppConstants.appName} - ${DateTime.now()}]: $message$_reset";
  }
}
