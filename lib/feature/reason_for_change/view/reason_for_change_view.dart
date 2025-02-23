import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:quit_gambling/feature/reason_for_change/view/reason_details_view.dart';
import 'package:quit_gambling/product/constant/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReasonsForChangeView extends StatefulWidget {
  const ReasonsForChangeView({super.key});

  @override
  State<ReasonsForChangeView> createState() => _ReasonsForChangeViewState();
}

class _ReasonsForChangeViewState extends State<ReasonsForChangeView> {
  List<String> reasons = [];
  final TextEditingController _reasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadReasons();
  }

  Future<void> _loadReasons() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      reasons = prefs.getStringList('reasons') ?? [];
    });
  }

  Future<void> _saveReasons() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('reasons', reasons);
  }

  void _addReason(String reason) {
    if (reason.isNotEmpty) {
      setState(() {
        reasons.add(reason);
        _saveReasons();
      });
    }
  }

  void _showAddReasonSheet() {
    _reasonController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1B35),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: context.sized.height * 0.9,
          color: const Color(0xff1c1c1e),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: CupertinoColors.systemBlue,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_reasonController.text.isNotEmpty) {
                              _addReason(_reasonController.text);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: CupertinoColors.systemBlue,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "New reason",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff2c2c2e),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            minLines: 1,
                            maxLines: 5,
                            controller: _reasonController,
                            autofocus: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Enter your reason',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(44),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SafeArea(
            child: NavigationToolbar(
              leading: const CupertinoNavigationBarBackButton(
                color: Colors.white,
              ),
              middle: const Text(
                'Reasons for change',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _showAddReasonSheet,
                child: const Icon(
                  CupertinoIcons.plus,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeConstants().getBackgroundLinearGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: reasons.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 400,
                              height: 400,
                              child: Lottie.asset(
                                'assets/lottie/empty.json',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const Text(
                              'No Reasons Yet',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'Why have you made the decision to quit? Add your own personal reasons why it\'s time to change.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: reasons.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => ReasonDetailsView(
                                    reasonText: reasons[index],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                reasons[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.keyboard_arrow_right_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  onPressed: _showAddReasonSheet,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New Reason',
                        style: TextStyle(
                          color: Color(0xFF1A1B35),
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        CupertinoIcons.plus,
                        color: Color(0xFF1A1B35),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
}
