import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:offbeat_pravasi_v2/common/common_exports.dart';
import 'package:barcode_widget/barcode_widget.dart';

class TrekTicketScreen extends StatefulWidget {
  final String userId;
  final String trekName;
  final String trekImage;
  final String trekLocation;
  final String trekId;
  final double trekCost;
  final DateTime trekDate;
  final String trekDifficulty;
  final String transactionId;

  const TrekTicketScreen({
    super.key,
    required this.trekName,
    required this.trekImage,
    required this.trekLocation,
    required this.trekId,
    required this.trekCost,
    required this.trekDate,
    required this.trekDifficulty,
    required this.transactionId,
    required this.userId,
  });

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
                                widget.trekImage,
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
                                    widget.trekName,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    widget.trekLocation,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '₹${widget.trekCost.toStringAsFixed(2)}',
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
                              '${widget.trekDate.day}/${widget.trekDate.month}/${widget.trekDate.year}',
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
                              widget.trekDifficulty,
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
                              '₹${widget.trekCost.toStringAsFixed(2)}',
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
                              '₹${(widget.trekCost + 120).toStringAsFixed(2)}',
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
                              // Barcode Section
                              Center(
                                child: Column(
                                  children: [
                                    BarcodeWidget(
                                      barcode: Barcode
                                          .code128(), // Choose barcode type
                                      data:
                                          'Txn:${widget.transactionId}|User:${widget.userId}|Trek:${widget.trekId}',
                                      width: 200,
                                      height: 80,
                                      drawText: false,
                                      backgroundColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 8),
                              Text(
                                widget.transactionId,
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
