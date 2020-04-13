import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kmitl_fitness_app/data/entitys/entitys.dart';
import 'package:kmitl_fitness_app/locator.dart';
import 'package:kmitl_fitness_app/models/models.dart';
import 'package:kmitl_fitness_app/ui/widgets/widgets.dart';
import 'package:kmitl_fitness_app/util/datamodels/dialog_type.dart';
import 'package:kmitl_fitness_app/util/services/dialog_service.dart';

class LockerPage extends StatelessWidget {
  LockerPage({Key key, this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return LockerPageChild(user: user);
  }
}

class LockerPageChild extends StatefulWidget {
  final User user;
  const LockerPageChild({Key key, this.user}) : super(key: key);
  @override
  _LockerPageStateChild createState() => _LockerPageStateChild(user: user);
}

class _LockerPageStateChild extends State<LockerPageChild> {
  final User user;
  _LockerPageStateChild({this.user});
  LockerModel lockerModel;
  TextEditingController textController = TextEditingController();
  final dialogService = locator<DialogService>();
  void checkPincode(String lockerId) async {
    final response = await dialogService
        .showDialog(dialogType: InputTextDialog(), parameters: {
      'title': 'Please enter pincode.',
      'textInButton': 'submit',
      'content': TextFormField(
        textAlign: TextAlign.center,
        keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        controller: textController,
      ),
      'uid': user.uid
    });
    if (response.confirmed) {
      print('confirmed');
      final result = await lockerModel.verifyPincode(textController.text,lockerId);
      if( result == 0){
        print('verify success');
      }else{
        print('verify fail');
        print('error code : $result');
      }
    } else {
      print('unconfirmed');
    }
  }

  @override
  void initState() {
    super.initState();
    lockerModel = LockerModel(uid: user.uid);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Locker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange[900],
      ),
      body: StreamBuilder(
        stream: lockerModel.lockers,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasError) {
            return LoadingWidget(height: 50, width: 50);
          } else if (asyncSnapshot.data == null) {
            return new Text("Empty data!");
          } else {
            List<Locker> lockers = new List<Locker>();
            for (var i in asyncSnapshot.data) {
              if (i.id != 'pinCode') {
                lockers.add(i);
              }
            }
            for(var i in lockers){
              if(i.user == user.uid){
                return controlLocker(context,i.isLocked);
              }
            }
            return selectLocker(context);
          }
        },
      ),
    );
  }
  Widget selectLocker(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          Text(
            "Select a locker to use",
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 300,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Center(
              child: StreamBuilder(
                stream: lockerModel.lockers,
                builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return LoadingWidget(height: 50, width: 50);
                  } else if (asyncSnapshot.data == null) {
                    return new Text("Empty data!");
                  } else {
                    List<Locker> lockers = new List<Locker>();
                    for (var i in asyncSnapshot.data) {
                      if (i.id != 'pinCode') {
                        lockers.add(i);
                      }
                    }
                    return GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        children: List.generate(9, (index) {
                          return FlatButton(
                            onPressed: lockers[index].user != ''
                                ? null
                                : () {
                                    checkPincode(index.toString());
                                  },
                            child: Column(children: <Widget>[
                              Icon(
                                Icons.lock,
                                color: lockers[index].user != ''
                                    ? Colors.black
                                    : Colors.green,
                              ),
                              Text('No ' + index.toString() + '.'),
                            ]),
                          );
                        }));
                  }
                },
              ),
            ),
          ),
        ]));
  }

  Widget controlLocker(BuildContext context,bool isLocked) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            isLocked?'Your locker is LOCKED':'Your locker is UNLOCKED',
            style: TextStyle(
                color: Colors.grey[600],
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Icon(
              isLocked?Icons.lock:Icons.lock_open,
              size: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AnimatedContainer(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: isLocked?Colors.grey[600]:Colors.orange[900],
                borderRadius: BorderRadius.all(Radius.circular(100))),
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: FlatButton(
                onPressed: () async {
                  if(isLocked){
                    final result = await lockerModel.open();
                    if( result == 0){
                      print('open success');
                    }else{
                       print('open failed');
                       print('error code : $result');
                    }
                  }else{
                    final result = await lockerModel.lock();
                     if( result == 0){
                      print('close success');
                    }else{
                       print('close failed');
                       print('error code : $result');
                    }
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  isLocked?'UNLOCK':'LOCK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: FlatButton(
                onPressed: () async {
                  final result = await lockerModel.returnLocker();
                  if (result == 0) {
                    print('return success');
                  } else {
                    print('return failed');
                    print('error code: $result');
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  'Return',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
