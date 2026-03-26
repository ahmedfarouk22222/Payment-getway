class PaymentIntentRequestModel {
  final String amount;
  final String currency;
  PaymentIntentRequestModel({
    required this.amount,
    required this.currency,
  });
  tojson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}
