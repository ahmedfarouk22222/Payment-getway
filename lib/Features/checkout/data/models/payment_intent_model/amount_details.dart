import 'tip.dart';

class AmountDetails {
  Tip? tip;

  AmountDetails({this.tip});

  Map<String, dynamic> toJson() => {
        'tip': tip?.toJson(),
      };
}
