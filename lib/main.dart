import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:provider/provider.dart';
import 'package:quit_gambling/feature/main_view.dart';
import 'package:quit_gambling/log.dart';
import 'package:quit_gambling/product/services/abstinence_tracker_service.dart';
import 'package:quit_gambling/product/services/nova_mind_provider.dart';
import 'package:quit_gambling/feature/main_view.dart';
import 'package:quit_gambling/log.dart';
import 'package:quit_gambling/product/services/abstinence_tracker_service.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart';
import 'package:uni_links2/uni_links.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Superwall.configure('pk_f349f26d93f37ea0f76a8cb9c76f782fcea7ae5494f8aec3');
  } catch (e) {
    Log().error('Superwall error: $e');
  }

  await HomeWidget.setAppGroupId('group.com.example.quitbet');

  final trackerService = AbstinenceTrackerService();
  await trackerService.init();

  await trackerService.updateHomeScreenWidget();

  final initialUri = await getInitialUri();
  if (initialUri != null && initialUri.toString().contains('widget/refresh')) {
    await trackerService.updateHomeScreenWidget();
  }
  uriLinkStream.listen((Uri? uri) async {
    if (uri != null && uri.toString().contains('widget/refresh')) {
      await trackerService.updateHomeScreenWidget();
    }
  });

  runApp(const BetOff());
}

class BetOff extends StatelessWidget {
  const BetOff({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatProvider(),
      child: MaterialApp(
        title: 'QUITBET',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          cupertinoOverrideTheme: const NoDefaultCupertinoThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.white,
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
            selectionHandleColor: Colors.white,
            selectionColor: Colors.white.withOpacity(.5),
          ),
        ),
        // home: const WelcomeView(),
        home: const MainView(),
      ),
    );
  }
}
