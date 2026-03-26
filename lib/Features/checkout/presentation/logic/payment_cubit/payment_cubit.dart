import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:checkout_payment_ui/Features/checkout/data/models/payment_intent_request_model.dart';
import 'package:checkout_payment_ui/Features/checkout/data/repo/payment_repo.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.paymentRepo) : super(PaymentInitial());
  final PaymentRepo paymentRepo;
  Future makePayment(
      {required PaymentIntentRequestModel paymentIntentRequestModel}) async {
    emit(PaymentLoading());
    var data = await paymentRepo.makePayment(
        paymentIntentRequestModel: paymentIntentRequestModel);
    data.fold((error) {
      emit(PaymentFailurer(errorMessage: error.errorMessage));
    }, (successs) {
      emit(PaymentSuccess());
    });
  }

  @override
  void onChange(Change<PaymentState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
