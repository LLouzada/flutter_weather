import 'package:flutter/foundation.dart';
import 'package:flutter_weather/core/config/app_constants.dart';

mixin AppLogger {
  final bool _isDebugMode = AppConstants.isDebugMode;
  bool _isLoggerInitialized = false;

  // Códigos de escape ANSI
  static const String _reset = '\x1B[0m';
  static const String _green = '\x1B[32m';
  static const String _red = '\x1B[31m';
  // static const String _yellow = '\x1B[33m';

  void initLogger() {
    _defineDebugPrint();
    _isLoggerInitialized = true;
  }

  /// Debug log
  void logD(String message) {
    if (!_isLoggerInitialized) {
      initLogger();
    }
    debugPrint(_formatMessage(message, color: _green));
  }

  /// Error log
  void logE(String message) {
    if (!_isLoggerInitialized) {
      initLogger();
    }
    debugPrint(_formatMessage(message, color: _red));
  }

  void _defineDebugPrint() {
    // Se não estiver no modo debug, suprime as mensagens de debug.
    if (!kDebugMode && !_isDebugMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  String _formatMessage(String? message, {String? color}) {
    return "$color[${AppConstants.appName} - ${DateTime.now()}]: $message$_reset \n";
  }
}
