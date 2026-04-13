import 'package:checkout_payment_ui/Features/checkout/data/models/customer_request_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/customer_response_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/init_payment_sheet_request_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_request_model.dart';
import 'package:checkout_payment_ui/core/utils/api_keys.dart';
import 'package:checkout_payment_ui/core/utils/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  Future<CustomerResponseModel> createCustomer(
      CustomerRequestModel customerRequestModel) async {
    var response = await apiService.post(
        contentType: Headers.formUrlEncodedContentType,
        body: customerRequestModel.tojson(),
        url: 'https://api.stripe.com/v1/customers',
        token: ApiKeys.secretKey);

    var customerResponse = CustomerResponseModel.fromJson(response.data);
    return customerResponse;
  }

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

  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    var response = await apiService.post(
        contentType: Headers.formUrlEncodedContentType,
        body: {'customer': customerId},
        url: 'https://api.stripe.com/v1/ephemeral_keys',
        token: ApiKeys.secretKey,
        headers: {
          'Authorization': "Bearer ${ApiKeys.secretKey}",
          'Stripe-Version': '2024-06-20'
        });

    var ephemeralKeyResponse = EphemeralKeyModel.fromJson(response.data);
    return ephemeralKeyResponse;
  }

  initPaymentSheet({
    required InitPaymentSheetRequestModel initPaymentSheetRequestModel,
  }) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: initPaymentSheetRequestModel.clientSecret,
          merchantDisplayName: 'Ahmed Farouk',
          customerEphemeralKeySecret:
              initPaymentSheetRequestModel.ephemeralKeySecret,
          customerId: initPaymentSheetRequestModel.customerId),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentRequestModel paymentIntentRequest,
  }) async {
    var ephemeralKey =
        await createEphemeralKey(customerId: paymentIntentRequest.customerID);
    var createPaymentIntentModel =
        await createPaymentIntent(paymentIntentRequest);
    var initPaymentSheetRequestModel = InitPaymentSheetRequestModel(
        clientSecret: createPaymentIntentModel.clientSecret!,
        ephemeralKeySecret: ephemeralKey.secret!,
        customerId: paymentIntentRequest.customerID);
    await initPaymentSheet(
        initPaymentSheetRequestModel: initPaymentSheetRequestModel);
    await displayPaymentSheet();
  }
}
