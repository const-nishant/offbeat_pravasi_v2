import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:offbeat_pravasi_v2/modules/home/widgets/payment_successful_modal.dart';

import '../../notification/notification_services.dart';

class PaymentMethodModal extends StatelessWidget {
  final String userId;
  final String trekName;
  final String trekImage;
  final String trekLocation;
  final String trekId;
  final double trekCost;
  final String trekDate;
  final String trekDifficulty;

  const PaymentMethodModal({
    super.key,
    required this.trekName,
    required this.trekDate,
    required this.trekCost,
    required this.trekId,
    required this.trekImage,
    required this.trekLocation,
    required this.trekDifficulty,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Payment method",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildPaymentCard(
            context,
            icon: Icons.credit_card,
            title: 'Mastercard',
            cardNumber: '4827 8472 7423 ****',
            selected: true,
          ),
          const SizedBox(height: 12),
          _buildPaymentCard(
            context,
            icon: Icons.credit_card,
            title: 'Visa',
            cardNumber: '1234 6672 6543 ****',
            selected: false,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () async {
                // Trigger payment action here
                context.pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => PaymentSuccessModal(
                    trekCost: trekCost,
                    trekDate: trekDate,
                    trekDifficulty: trekDifficulty,
                    trekId: trekId,
                    trekImage: trekImage,
                    trekLocation: trekLocation,
                    trekName: trekName,
                    userId: userId,
                  ),
                );
                await sendDirectNotification(
                  notificationTitle: 'Booking Confirmation',
                  notificationBody:
                      'Your booking for $trekName has been confirmed!',
                );
              },
              child: Text(
                "Confirm payment",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String cardNumber,
      required bool selected}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected
              ? Theme.of(context).colorScheme.secondary
              : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    )),
                Text(cardNumber,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    )),
              ],
            ),
          ),
          Icon(
            selected
                ? Icons.radio_button_checked
                : Icons.radio_button_off_outlined,
            color: selected
                ? Theme.of(context).colorScheme.secondary
                : Colors.grey,
          ),
        ],
      ),
    );
  }
}
