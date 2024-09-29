import 'package:flutter/foundation.dart';
import 'package:flutter_weather/app/config/app_constants.dart';

mixin AppLogger {
  final _isDebugMode = AppConstants.isDebugMode;
  var _isLoggerInitialized = false;

  void _initLoggger() {
    _defineDebugPrint();
    _isLoggerInitialized = true;
  }

  void log(String message) {
    if (!_isLoggerInitialized) {
      _initLoggger;
    }
    debugPrint(_formatMessage(message));
  }

  void _defineDebugPrint() {
    // Se não estiver no modo debug, suprime as mensagens de debug.
    if (!kDebugMode && !_isDebugMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
  }

  String _formatMessage(String? message) {
    // Formata a mensagem com o nome do app e a data/hora atual
    return "[${AppConstants.appName} - ${DateTime.now()}]: $message";
  }
}
