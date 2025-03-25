import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';

class TrekTicketScreen extends StatefulWidget {
  const TrekTicketScreen({super.key});

  @override
  State<TrekTicketScreen> createState() => _TrekTicketScreenState();
}

class _TrekTicketScreenState extends State<TrekTicketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Header Row
              Row(
                children: [
                  // Close Button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      style: ButtonStyle(
                        side: WidgetStateProperty.all(
                          BorderSide(
                            color:
                                Theme.of(context).colorScheme.onInverseSurface,
                            width: 2,
                          ),
                        ),
                        iconColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      icon: Icon(
                        LucideIcons.chevronLeft,
                        size: 20,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        context.pop();
                      },
                    ),
                  ),
                  const SizedBox(width: 50),
                  // Title
                  const Text(
                    'Treks Ticket',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 110),

              // Trek Ticket Container
              Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 3,
                        blurRadius: 9,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Trek Details
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kedarkantha Trek',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Uttarakhand, India',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '₹1500.00',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Date and Trek Type
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date:',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              'March 30, 2025',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trek Difficulty:',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              'Intermediate',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Price Breakdown
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              '₹1380.00',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'GST',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              '₹120.00',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24, thickness: 1),

                        // Total Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₹1500.00',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Barcode
                        Center(
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                child: Text(
                                  '||||| || ||| | || ||||| | ||',
                                  style: TextStyle(letterSpacing: 2),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'TrekID-2345-PRAVASI',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Spacer(),

              // Download Button
              LargeButton(
                onPressed: () {},
                text: 'Download Recipt PDF',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
