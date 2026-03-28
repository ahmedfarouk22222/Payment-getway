class PaymentIntentRequestModel {
  final int amount;
  final String currency;
  PaymentIntentRequestModel({
    required this.amount,
    required this.currency,
  });
  tojson() {
    return {
      'amount': amount * 100,
      'currency': currency,
    };
  }
}
