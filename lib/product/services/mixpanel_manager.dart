import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixpanelManager {
  static Mixpanel? _instance;

  static Future<Mixpanel> get instance async {
    _instance ??= await Mixpanel.init("5ff365c651c4e81b7598e2465c17fc19",
        trackAutomaticEvents: true);
    return _instance!;
  }

  // Sadece iki temel event
  static Future<void> trackOnboardingStarted() async {
    final mixpanel = await instance;
    mixpanel.track('Onboarding Started');
  }

  static Future<void> trackOnboardingStep({
    required int stepNumber,
  }) async {
    final mixpanel = await instance;
    mixpanel.track('Onboard $stepNumber');
  }
}
