import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DialogsWidget {
  DialogsWidget._();

  static Future<void> warning({
    required BuildContext context,
    String? title,
    required String message,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: title != null ? Text(title) : null,
        content: SingleChildScrollView(
          child: Text(
            message,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> loading({
    required BuildContext context,
    required String title,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => SimpleDialog(
        contentPadding: const EdgeInsets.fromLTRB(
          24,
          12,
          24,
          16,
        ),
        title: Text(title),
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
