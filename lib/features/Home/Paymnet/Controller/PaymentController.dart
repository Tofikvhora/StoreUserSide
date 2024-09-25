import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:serviceandstore/features/Home/OrderPage/OrderSuccess.dart';
import 'package:serviceandstore/features/Home/OrderPage/OrderUnSuccess.dart';

abstract class PaymentController {
  Future<void> payToOrder(BuildContext context, var data, int total);
}

class PaymentMethod extends PaymentController with ChangeNotifier {
  @override
  Future<void> payToOrder(BuildContext context, var data, int total) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final _razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_AG3E7JA8dyQQEi',
      'amount': total * 100,
      'name': auth.currentUser!.email,
      'description': data["Details-Name"].toString(),
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'theme': {'color': '#01806F'},
      'prefill': {'contact': '+919601874036', 'email': 'tofikvora@gmail.com'},
      'external': {
        'wallets': ['paytm']
      },
      'checkout': {"name": "Tofik Vhora"}
    };
    _razorpay.open(options);
    void _handlePaymentSuccess(PaymentSuccessResponse response) {
      // Do something when payment succeeds
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OrderSuccess()));
    }

    void _handlePaymentError(PaymentFailureResponse response) {
      // Do something when payment fails
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const OrderUnSuccess()));
    }

    void _handleExternalWallet(ExternalWalletResponse response) {
      // Do something when an external wallet was selected
    }
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
}
