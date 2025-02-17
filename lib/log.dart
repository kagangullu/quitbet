import 'dart:developer';

class Log {
  Log._internal();

  static final Log _ = Log._internal();

  factory Log() {
    return _;
  }

  void ok(dynamic str) => log('\x1B[32m$str\x1B[32m', name: _logName);

  void error(dynamic str) => log('\x1B[31m$str\x1B[31m', name: _logName);

  void warn(dynamic str) => log('\x1B[33m$str\x1B[33m', name: _logName);

  void lol(dynamic str) => log('\x1B[35m$str\x1B[35m', name: _logName);

  void safe(dynamic str) => log('\x1B[36m$str\x1B[36m', name: _logName);

  void dark(dynamic str) => log('\x1B[30m$str\x1B[30m', name: _logName);

  void light(dynamic str) => log('\x1B[37m$str\x1B[37m', name: _logName);

  void none(dynamic str) => log(str.toString(), name: _logName);

  static const String _logName = 'log';
}
