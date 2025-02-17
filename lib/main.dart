import 'package:flutter/material.dart';
import 'package:quit_gambling/feature/home/view/home_view.dart';
import 'package:quit_gambling/feature/onboard/view/welcome_view.dart';
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
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionHandleColor: Colors.white,
          selectionColor: Colors.white.withOpacity(0.5),
        ),
      ),
      // home: const WelcomeView(),
      home: const HomePage(),
    );
  }
}
