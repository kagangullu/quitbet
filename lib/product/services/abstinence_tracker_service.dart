import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbstinenceTrackerService {
  static const String _startTimeKey = 'abstinence_start_time';
  static const String _isActiveKey = 'is_tracking_active';

  static final AbstinenceTrackerService _instance =
      AbstinenceTrackerService._internal();
  factory AbstinenceTrackerService() => _instance;
  AbstinenceTrackerService._internal();

  DateTime? _startTime;
  bool _isInitialized = false;
  bool _isActive = false;

  bool get isActive => _isActive;

  Future<void> init() async {
    if (_isInitialized) return;

    final prefs = await SharedPreferences.getInstance();
    final milliseconds = prefs.getInt(_startTimeKey);
    _isActive = prefs.getBool(_isActiveKey) ?? false;

    if (milliseconds != null && _isActive) {
      _startTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    }

    await updateHomeScreenWidget();

    _isInitialized = true;
  }

  Future<void> setStartTime(DateTime time) async {
    _startTime = time;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_startTimeKey, time.millisecondsSinceEpoch);

    await updateHomeScreenWidget();
  }

  Future<void> resetTracking() async {
    _startTime = null;
    _isActive = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_startTimeKey);
    await prefs.setBool(_isActiveKey, false);
    await updateHomeScreenWidget();
  }

  DateTime? getStartTime() {
    return _startTime;
  }

  Duration getAbstinenceDuration() {
    if (_startTime == null || !_isActive) {
      return Duration.zero;
    }
    return DateTime.now().difference(_startTime!);
  }

  Future<void> startTracking() async {
    _startTime = DateTime.now();
    _isActive = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_startTimeKey, _startTime!.millisecondsSinceEpoch);
    await prefs.setBool(_isActiveKey, true);
    await updateHomeScreenWidget();
  }

  String getMainDurationText() {
    if (_startTime == null) return '0 days';

    final duration = getAbstinenceDuration();

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (days > 0) {
      return '$days days';
    } else if (hours > 0) {
      return '$hours hr';
    } else if (minutes > 0) {
      return '$minutes m';
    } else {
      return '$seconds s';
    }
  }

  String getSecondaryDurationText() {
    if (_startTime == null) return '';

    final duration = getAbstinenceDuration();

    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;

    if (days > 0) {
      String text = '';
      if (hours > 0) {
        text += '${hours}hr ';
      }
      if (minutes > 0 || hours > 0) {
        text += '${minutes}m ';
      }
      text += '${seconds}s';
      return text;
    } else if (hours > 0) {
      return '${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${seconds}s';
    }
    return '';
  }

  int calculateBrainProgress() {
    if (_startTime == null) return 0;
    final daysPassed = getAbstinenceDuration().inDays;
    return ((daysPassed / 90) * 100).round().clamp(0, 100);
  }

  Future<void> updateHomeScreenWidget() async {
    if (_startTime == null) return;

    await HomeWidget.saveWidgetData(
        'abstinence_start_time', _startTime!.millisecondsSinceEpoch);

    await HomeWidget.updateWidget(
      iOSName: 'GamblingTrackerWidget',
    );
  }
}
