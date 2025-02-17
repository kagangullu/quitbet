import 'package:flutter/material.dart';
import 'package:superwallkit_flutter/superwallkit_flutter.dart';

class PaywallView extends StatefulWidget {
  const PaywallView({super.key});

  @override
  State<PaywallView> createState() => _PaywallViewState();
}

class _PaywallViewState extends State<PaywallView> {
  String selectedPlan = 'yearly';
  final PaywallPresentationHandler _handler = PaywallPresentationHandler();

  @override
  void initState() {
    super.initState();
    _setupPaywallHandler();
  }

  void _setupPaywallHandler() {
    _handler.onPresent((paywallInfo) async {
      String name = await paywallInfo.name;
      debugPrint("Paywall presented: $name");
    });

    _handler.onDismiss((paywallInfo) async {
      String name = await paywallInfo.name;
      debugPrint("Paywall dismissed: $name");
    });

    _handler.onError((error) {
      debugPrint("Paywall error: $error");
    });

    _handler.onSkip((skipReason) async {
      String description = await skipReason.description;
      debugPrint("Paywall skipped: $description");
    });
  }

  void _handleStartJourney() {
    final params = <String, dynamic>{
      'selected_plan': selectedPlan,
      'view_source': 'paywall_view',
    };

    Superwall.shared.registerEvent(
      'start_journey',
      params: params,
      handler: _handler,
      feature: () {
        debugPrint('Journey started successfully!');
        Navigator.pop(context);
      },
    );
  }

  void _handleRestore() {
    Superwall.shared.registerEvent(
      'restore_purchase',
      handler: _handler,
      feature: () {
        debugPrint('Purchase restored successfully!');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1B1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: _handleRestore,
          child: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Restore',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Logo
              Image.asset(
                'assets/images/graph.png',
                height: 40,
              ),
              const SizedBox(height: 24),

              // Description text
              const Text(
                'Get unlimited access to QUITTR including: Personalised and Science-Based Custom Plan, Adult Content Blocker, Community Chat, Streak Tracking, Daily Pledges, Recovery Progress + much more!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Phone screenshots with gradient overlay
              SizedBox(
                height: 400,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/graph.png',
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF1C1B1F).withOpacity(0),
                              const Color(0xFF1C1B1F),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Subscription options
              Row(
                children: [
                  Expanded(
                    child: _SubscriptionCard(
                      title: 'MONTHLY',
                      price: '₺499,99',
                      period: 'mo',
                      isSelected: selectedPlan == 'monthly',
                      onTap: () => setState(() => selectedPlan = 'monthly'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _SubscriptionCard(
                          title: 'YEARLY',
                          price: '₺124,99',
                          period: 'mo',
                          isSelected: selectedPlan == 'yearly',
                          onTap: () => setState(() => selectedPlan = 'yearly'),
                        ),
                        Positioned(
                          top: -12,
                          right: -8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              'SAVE 60%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Start Journey Button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF9C42F5),
                      Color(0xFF4B8CF5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: ElevatedButton(
                  onPressed: _handleStartJourney,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'START MY JOURNEY',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Footer text
              const Text(
                "Purchase appears as 'ITUNES STORE'.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cancel Anytime ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '✅',
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    ' Money back guarantee ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '🛡️',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String period;
  final bool isSelected;
  final VoidCallback onTap;

  const _SubscriptionCard({
    required this.title,
    required this.price,
    required this.period,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' / $period',
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
