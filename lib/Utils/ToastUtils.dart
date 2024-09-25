import 'package:fluttertoast/fluttertoast.dart';
import 'package:serviceandstore/Constant/Colors.dart';

class ToastUtils {
  showToastMethod(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        backgroundColor: ColorsOfApp.textColor,
        textColor: ColorsOfApp.primaryColor);
  }
}
