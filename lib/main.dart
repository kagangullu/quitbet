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

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Kumar Bırakma Yardımcısı',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class ContentBlockerService {
//   static const platform = MethodChannel('com.example.quitbet/content_blocker');

//   Future<void> reloadContentBlocker() async {
//     try {
//       await platform.invokeMethod('reloadContentBlocker');
//     } on PlatformException catch (e) {
//       debugPrint('İçerik engelleyici yenilenemedi: ${e.message}');
//     }
//   }

//   Future<bool> getContentBlockerStatus() async {
//     try {
//       final bool isEnabled =
//           await platform.invokeMethod('getContentBlockerStatus');
//       return isEnabled;
//     } on PlatformException catch (e) {
//       debugPrint('İçerik engelleyici durumu alınamadı: ${e.message}');
//       return false;
//     }
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final ContentBlockerService _contentBlockerService = ContentBlockerService();
//   bool _isBlockerEnabled = false;
//   int _kumarTemizGunSayisi = 0;
//   final _prefs = SharedPreferences.getInstance();

//   @override
//   void initState() {
//     super.initState();
//     _checkBlockerStatus();
//     _loadKumarTemizGunSayisi();
//   }

//   Future<void> _checkBlockerStatus() async {
//     final status = await _contentBlockerService.getContentBlockerStatus();
//     setState(() {
//       _isBlockerEnabled = status;
//     });
//   }

//   Future<void> _reloadBlocker() async {
//     await _contentBlockerService.reloadContentBlocker();
//     await _checkBlockerStatus();
//   }

//   Future<void> _loadKumarTemizGunSayisi() async {
//     final prefs = await _prefs;
//     final baslangicTarihi = DateTime.parse(
//         prefs.getString('baslangic_tarihi') ??
//             DateTime.now().toIso8601String());

//     setState(() {
//       _kumarTemizGunSayisi = DateTime.now().difference(baslangicTarihi).inDays;
//     });
//   }

//   Future<void> _resetKumarTemizGunSayisi() async {
//     final prefs = await _prefs;
//     await prefs.setString('baslangic_tarihi', DateTime.now().toIso8601String());
//     await _loadKumarTemizGunSayisi();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kumar Bırakma Yardımcısı'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Kumar Temiz Gün Sayısı',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '$_kumarTemizGunSayisi gün',
//                       style: const TextStyle(
//                           fontSize: 36, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: _resetKumarTemizGunSayisi,
//                       child: const Text('Sayacı Sıfırla'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Safari İçerik Engelleyici',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         Switch(
//                           value: _isBlockerEnabled,
//                           onChanged: (value) {
//                             showDialog(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 title: const Text('Safari Ayarları'),
//                                 content: const Text(
//                                     'İçerik engelleyiciyi etkinleştirmek için:\n'
//                                     '1. Ayarlar > Safari > İçerik Engelleyiciler\'e gidin\n'
//                                     '2. Uygulamayı etkinleştirin'),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () => Navigator.pop(context),
//                                     child: const Text('Tamam'),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       'Kumar sitelerine erişimi engellemek için Safari içerik engelleyiciyi etkinleştirin.',
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: _reloadBlocker,
//                       child: const Text('Engelleyiciyi Yenile'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Yardım Hatları',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 8),
//                     Text('Yeşilay Danışmanlık Merkezi (YEDAM)'),
//                     Text('Tel: 115'),
//                     SizedBox(height: 8),
//                     Text('ALO 171 Sigara ve Diğer Bağımlılıklar Danışma Hattı'),
//                     Text('Tel: 171'),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
