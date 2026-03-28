import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_request_model.dart';
import 'package:checkout_payment_ui/core/utils/api_keys.dart';
import 'package:checkout_payment_ui/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  final ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentRequestModel paymentIntentRequest) async {
    var response = await apiService.post(
        contentType: Headers.formUrlEncodedContentType,
        body: paymentIntentRequest.tojson(),
        url: 'https://api.stripe.com/v1/payment_intents',
        token: ApiKeys.secretKey);

    var parsePaymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return parsePaymentIntentModel;
  }

  initPaymentSheet({required String paymentIntentClientSecret}) {
    Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Ahmed Farouk'),
    );
  }

  Future displayPaymentSheet() async {
    Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentRequestModel paymentIntentRequest,
  }) async {
    var createPaymentIntentModel =
        await createPaymentIntent(paymentIntentRequest);
    await initPaymentSheet(
        paymentIntentClientSecret: createPaymentIntentModel.clientSecret!);
    await displayPaymentSheet();
  }
}
