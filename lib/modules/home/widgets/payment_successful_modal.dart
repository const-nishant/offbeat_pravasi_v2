import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessModal extends StatelessWidget {
  const PaymentSuccessModal({super.key});

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
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            radius: 40,
            child: Icon(Icons.check_circle,
                color: Theme.of(context).colorScheme.secondary, size: 50),
          ),
          const SizedBox(height: 20),
          Text(
            "Payment Success",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Booking confirmed! Thank you for choosing Offbeat Pravasi for your adventure.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
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
              onPressed: () {
                // View ticket action here
                context.pop();
                context.push('/trek-ticket');
              },
              child: Text(
                "View Ticket",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
