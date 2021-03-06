import 'package:flutter/material.dart';
import 'package:kmitl_fitness_app/locator.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:kmitl_fitness_app/util/datamodels/alert_response.dart';
import 'package:kmitl_fitness_app/util/datamodels/dialog_type.dart';
import 'package:kmitl_fitness_app/util/services/dialog_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(DialogType dialogType, Map<String, dynamic> parameters) {
    if (dialogType is TreadmillDialog) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => TreadmillShowDialog(
          title: 'Treadmill is ready!',
          user: parameters['user'],
          startTime: null,
          isCanSkip: parameters['isCanskip'],
        ),
      );
    }else if( dialogType is InputTextDialog){
        Alert(
        context: context,
        title: parameters['title'],
        content: parameters['content'],
        closeFunction: () =>
            _dialogService.dialogComplete(AlertResponse(confirmed: false)),
        buttons: [
          DialogButton(
            child: Text(parameters['textInButton'],style:TextStyle(color: Colors.white)),
            onPressed: () {
              _dialogService.dialogComplete(AlertResponse(confirmed: true));
              Navigator.of(context).pop();
            },
          )
        ]).show();
    }
  }
}
