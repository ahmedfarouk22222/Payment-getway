import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_request_model.dart';
import 'package:checkout_payment_ui/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentRequestModel paymentIntentRequestModel});
}
