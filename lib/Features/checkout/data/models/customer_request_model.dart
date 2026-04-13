class CustomerRequestModel {
  final String name;

  CustomerRequestModel({required this.name});
  tojson() {
    return {
      'name': name,
    };
  }
}
