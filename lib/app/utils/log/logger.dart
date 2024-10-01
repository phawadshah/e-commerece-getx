import 'package:logger/logger.dart';

class KLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.all,
  );

  static void debug(String message) {
    _logger.d(message);
  }

  static void log(String message) {
    _logger.log(Logger.level, message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error]) {
    _logger.e(message, error: error, stackTrace: StackTrace.current);
  }
}
