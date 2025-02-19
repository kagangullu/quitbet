import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quit_gambling/feature/main_view.dart';
import 'package:quit_gambling/log.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    Superwall.configure('pk_f349f26d93f37ea0f76a8cb9c76f782fcea7ae5494f8aec3');
  } catch (e) {
    Log().error('Superwall error: $e');
  }

  runApp(const BetOff());
}

class BetOff extends StatelessWidget {
  const BetOff({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}
