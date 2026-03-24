import 'package:checkout_payment_ui/Features/checkout/presentation/views/my_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  Stripe.publishableKey =
      'pk_test_51TEHjz17vdk8k0iAihxLUB63yLosPa37urS7XHsMut8Iu2ZAbYdRMBIkB83nUSPd99ghCOm1sYdjBF6Qd1p8nWqZ00weV0YyED';
  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}
