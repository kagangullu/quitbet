import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020517),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'QUITBET',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: context.padding.onlyRightNormal,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(.3),
                  borderRadius: context.border.normalBorderRadius,
                ),
                child: Padding(
                  padding: context.padding.verticalLow / 2 +
                      context.padding.horizontalLow,
                  child: GradientText(
                    "🌟 Rate",
                    colors: const [Colors.white, Colors.amber],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gradient Bubble
            Center(
              child: Lottie.asset("assets/lottie/orb.json", height: 175),
            ),
            const SizedBox(height: 30),
            // Days Counter
            const Text(
              "You've been gambling-free for:",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),

            const Text(
              '7 days',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Timer
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xff1b1c1e),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '2hr 54m 58s',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(Icons.back_hand, 'Pledge'),
                _buildActionButton(Icons.self_improvement, 'Meditate'),
                _buildActionButton(Icons.refresh, 'Reset'),
                _buildActionButton(Icons.more_horiz, 'More'),
              ],
            ),
            const SizedBox(height: 30),
            // Progress Bar
            // Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xff001935),
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: const Color(0xff012a58), width: 1.5),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Brain Rewiring',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: 0.08,
                          minHeight: 8,
                          backgroundColor: Colors.black26,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.teal.shade300,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '8%',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Status Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildStatusCard(
                    "You're on track to quit by:",
                    'Jan 21, 2025',
                    Icons.check_circle_outline,
                    Colors.white,
                  ),
                  const SizedBox(width: 10),
                  _buildStatusCard(
                    'Tempted to Relapse:',
                    'False',
                    Icons.sentiment_satisfied_alt,
                    Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Panic Button
            const SizedBox(height: 20),
            // Additional Widgets
            _buildSectionTitle('Recent Activities'),
            _buildActivityList(),
            _buildSectionTitle('Your Progress'),
            _buildProgressSection(),
            _buildSectionTitle('Community Support'),
            _buildCommunitySection(),
            const SizedBox(height: 40), // Bottom padding
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xff450125),
                  borderRadius: context.border.highBorderRadius,
                  border: Border.all(
                    color: const Color(0xffcc000d),
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.exclamationmark_octagon),
                      SizedBox(width: 8),
                      Text(
                        'Panic Button',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            context.sized.emptySizedHeightBoxLow,
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Color(0xFF020517),
                    width: 0.5,
                  ),
                ),
              ),
              child: CupertinoTabBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                backgroundColor: const Color(0xff04092a),
                activeColor: Colors.white,
                inactiveColor: Colors.white54,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.square_grid_2x2),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.graph_square),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.doc_text),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.chat_bubble),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings),
                    label: '',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xff1b1c1e),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            icon,
            size: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff1b1c1e),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(icon, color: iconColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildActivityList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.emoji_emotions, color: Colors.teal),
            ),
            title: Text(
              'Completed meditation session',
              style: TextStyle(color: Colors.white.withOpacity(0.9)),
            ),
            subtitle: const Text(
              '2 hours ago',
              style: TextStyle(color: Colors.white54),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildProgressItem('Meditation streak', '5 days', 0.5),
          const SizedBox(height: 16),
          _buildProgressItem('Journal entries', '12 total', 0.4),
          const SizedBox(height: 16),
          _buildProgressItem('Community support', '8 messages', 0.3),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String title, String value, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: Colors.black12,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.teal.shade300,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCommunitySection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildCommunityCard(
            'Support Group',
            '15 members online',
            CupertinoIcons.group_solid,
          ),
          const SizedBox(height: 16),
          _buildCommunityCard(
            'Daily Challenge',
            'Meditation - 10 minutes',
            CupertinoIcons.star_fill,
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(String title, String subtitle, IconData icon) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.teal.withOpacity(0.2),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(icon, color: Colors.teal),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          CupertinoIcons.right_chevron,
          color: Colors.white54,
        ),
      ],
    );
  }
}
