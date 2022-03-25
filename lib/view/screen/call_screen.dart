import 'package:flutter/material.dart';
import 'package:telnyx_flutter_webrtc/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final logger = Logger();
  TextEditingController sipUserController = TextEditingController();
  TextEditingController sipPasswordController = TextEditingController();
  TextEditingController sipNameController = TextEditingController();
  TextEditingController sipNumberController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MainViewModel>(context, listen: true).observeResponses();
    Provider.of<MainViewModel>(context, listen: true).connect();
    bool registered =
        Provider.of<MainViewModel>(context, listen: true).registered;
    if (registered) {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:  SafeArea(
            child:
            DialPad(
                enableDtmf: true,
                outputMask: "",
                backspaceButtonIconColor: Colors.red,
                keyPressed: (value){
                  //ToDo DTMF
                  print('$value was pressed');
                },
                makeCall: (number){
                  //ToDo end call
                }
            )
        ),
      ),
    );
  }
}
