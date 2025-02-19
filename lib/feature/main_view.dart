// main_view.dart
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:quit_gambling/feature/analytics/view/analytics_view.dart';
import 'package:quit_gambling/feature/home/view/home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, this.selectedIndex = 0});
  final int selectedIndex;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late int _selectedIndex;
  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  final List<Widget> _pages = [
    const HomeView(),
    const AnalyticsView(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: _selectedIndex == 0 ? Colors.black : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedIndex == 0)
              Container(
                color: Colors.black,
                child: _PanicButton(
                  onTap: () {},
                ),
              ),
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30.0, sigmaY: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0
                        ? Colors.black
                        : Colors.grey.withOpacity(0.1),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 60,
                        child: _buildNavBar(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _NavItem(
          icon: CupertinoIcons.square_grid_2x2,
          isSelected: _selectedIndex == 0,
          onTap: () => _onItemTapped(0),
        ),
        _NavItem(
          icon: CupertinoIcons.graph_square,
          isSelected: _selectedIndex == 1,
          onTap: () => _onItemTapped(1),
        ),
        _NavItem(
          icon: CupertinoIcons.doc_text,
          isSelected: _selectedIndex == 2,
          onTap: () => _onItemTapped(2),
        ),
        _NavItem(
          icon: CupertinoIcons.chat_bubble,
          isSelected: _selectedIndex == 3,
          onTap: () => _onItemTapped(3),
        ),
        _NavItem(
          icon: Icons.menu_rounded,
          isSelected: _selectedIndex == 4,
          onTap: () => _onItemTapped(4),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedIndex = index;
    });
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 60,
        child: Center(
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white54,
            size: 30,
          ),
        ),
      ),
    );
  }
}

class _PanicButton extends StatelessWidget {
  const _PanicButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          context.padding.horizontalNormal + context.padding.onlyTopLow / 2,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xff2e060b),
          borderRadius: context.border.highBorderRadius,
          border: Border.all(
            color: const Color(0xff9e1e1e),
            width: 3,
          ),
        ),
        child: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.exclamationmark_octagon,
                size: 20,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Panic Button',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
