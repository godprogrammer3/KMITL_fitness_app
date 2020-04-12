

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:kmitl_fitness_app/util/datamodels/alert_response.dart';
import 'package:kmitl_fitness_app/util/datamodels/dialog_type.dart';

class DialogService {
  Function(DialogType,Map<String,dynamic>) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  void registerDialogListener(Function(DialogType,Map<String,dynamic>) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog(
      {
        @required DialogType dialogType,
        Map<String,dynamic> parameters,
      }) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(dialogType,parameters);
    return _dialogCompleter.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
