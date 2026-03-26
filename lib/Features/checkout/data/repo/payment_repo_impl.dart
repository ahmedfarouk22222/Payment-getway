import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_request_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/repo/payment_repo.dart';
import 'package:checkout_payment_ui/core/errors/failure.dart';
import 'package:checkout_payment_ui/core/utils/stripe_service.dart';
import 'package:dartz/dartz.dart';

class PaymentRepoImple extends PaymentRepo {
  final StripeService service = StripeService();

  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentRequestModel paymentIntentRequestModel}) async {
    try {
      await service.makePayment(
          paymentIntentRequest: paymentIntentRequestModel);
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
