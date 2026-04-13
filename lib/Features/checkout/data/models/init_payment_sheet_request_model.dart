class InitPaymentSheetRequestModel {
  final String clientSecret;
  final String ephemeralKeySecret;
  final String customerId;

  InitPaymentSheetRequestModel(
      {required this.clientSecret,
      required this.ephemeralKeySecret,
      required this.customerId});
}
