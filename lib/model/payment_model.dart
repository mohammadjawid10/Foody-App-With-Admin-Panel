class PaymentModel{
  String paymentId = "";
  String paymentType = "";
  String imagePayment = "";
  String transactionId = "";

  PaymentModel.empty();


  PaymentModel(
      {required this.paymentId,
      required this.paymentType,
      required this.imagePayment,
      required this.transactionId});

  PaymentModel.fromSessionData(Map<String, dynamic> json){
    paymentId = json['payment_id'] ?? "";
    paymentType = json['payment_type'] ?? "";
    imagePayment = json['image_payment'] ?? "";
    transactionId = json['transaction_id'] ?? "";
  }

  Map<String, dynamic> toJsonForSession() {
    Map<String, dynamic> json = {
      'payment_id': paymentId,
      'payment_type': paymentType,
      'image_payment': imagePayment,
      'transaction_id': transactionId,

    };
    return json;
  }

  @override
  String toString() {
    return 'PaymentModel{paymentId: $paymentId, paymentType: $paymentType, imagePayment: $imagePayment, transactionId: $transactionId}';
  }
}