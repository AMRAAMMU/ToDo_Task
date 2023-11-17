import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static void showErrorMessage({required String message}) {
    Get.snackbar(message, "(ERROR OCCURED!)",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.close,
          color: Colors.red,
        ));
  }

  static void showSuccessMessage({required String message}) {
    Get.snackbar(message, "",
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(
          Icons.check,
          color: Colors.green,
        ));
  }
}
