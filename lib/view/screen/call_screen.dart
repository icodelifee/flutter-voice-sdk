import 'package:flutter/material.dart';
import 'package:telnyx_flutter_webrtc/main_view_model.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';
import 'package:telnyx_flutter_webrtc/telnyx_webrtc/call.dart';
import 'package:telnyx_flutter_webrtc/view/widgets/dialpad_widget.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key? key, required this.title, this.call})
      : super(key: key);
  final String title;
  final Call? call;

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 8),
          Text(widget.call?.sessionDestinationNumber ?? "Unknown Caller"),
          const SizedBox(height: 8),
          DialPad(
            outputMask: "",
            backspaceButtonIconColor: Colors.red,
            dialButtonColor: Colors.red,
            makeCall: (number) {
              //End call
              Provider.of<MainViewModel>(context, listen: false).endCall();
            },
            keyPressed: (number) {
              Provider.of<MainViewModel>(context, listen: false).dtmf(number);
            },
          ),
          const SizedBox(height: 8),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                onPressed: () {
                  print("mic");
                  Provider.of<MainViewModel>(context, listen: false)
                      .muteUnmute();
                },
                icon: const Icon(Icons.mic)),
            IconButton(
                onPressed: () {
                  print("pause");
                  Provider.of<MainViewModel>(context, listen: false)
                      .holdUnhold();
                },
                icon: const Icon(Icons.pause))
          ])
        ],
      )),
    );
  }
}
