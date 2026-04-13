class PaymentIntentRequestModel {
  final int amount;
  final String currency;
  final String customerID;
  PaymentIntentRequestModel({
    required this.customerID,
    required this.amount,
    required this.currency,
  });
  tojson() {
    return {
      'amount': amount * 100,
      'currency': currency,
      'customer': customerID,
    };
  }
}
