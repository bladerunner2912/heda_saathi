import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:heda_saathi/authModule/widgets/app_bar.dart';
import 'package:heda_saathi/chatModule/widgets/chat_text.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../chat_model.dart';

class ChatScreenInstance extends StatefulWidget {
  final double dW;
  final double dH;
  final double tS;
  final String chatId;
  const ChatScreenInstance(
      {super.key,
      required this.dW,
      required this.dH,
      required this.tS,
      this.chatId = ''});

  @override
  State<ChatScreenInstance> createState() => _ChatScreenInstanceState();
}

class _ChatScreenInstanceState extends State<ChatScreenInstance> {
  List<Map<String, String>> userChat = [];
  List<Map<String, String>> recieverChat = [];
  TextEditingController ts = TextEditingController();

  bool show = false;
  FocusNode n = FocusNode();
  late IO.Socket socket;

  void connect() async {
    // socket =
    //     IO.io("https://f287-2409-4042-804-7e06-b50b-3a86-4b55-c544.in.ngrok.io", <String, dynamic>{
    //   "transports": ["websocket"],
    //   "autoConnect": false,
    // });
    // socket.connect();
    // socket.onConnect((data) => print('Connected'));
    // print(socket.connected);
    // socket.emit('/test', "Hello World");
  }

  @override
  void initState() {
    // connect();
    super.initState();
  }

  myInit() async {
    //load all chat from the chat class
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blueGrey.shade100,
      appBar: customAppBar(widget.dW),
      body : Center(child: Image.asset('assets/images/coming.png'),)
      // body: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      //   height: widget.dH,
      //   width: widget.dW,
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: widget.dH * 0.785,
      //         width: widget.dW,
      //         child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const Spacer(),
      //               ChatText(
      //                 chatText:
      //                     'aasdapfasjsfoiajdfoisdjfoiajdgoifdjasfiojassdiofjasiosdfjaoidfjaoissdfjoidadfjodaissjfoisafjaoissdfjioasdsfjoiasdfjioasdfjoiasjfdoiafdjoiasfdjoiasdjfoiasdfjioasfjoiafdjoisasjfoiajfiofawdwjs',
      //                 dW: widget.dW,
      //                 dateTime: '11:09',
      //                 isDelieverd: true,
      //                 byUser: true,
      //                 tS: widget.tS,
      //               ),
      //               ChatText(
      //                   dW: widget.dW,
      //                   tS: widget.tS,
      //                   chatText: 'Yes its been going fun.',
      //                   dateTime: '12:30',
      //                   isDelieverd: true,
      //                   byUser: false),
      //               ChatText(
      //                   dW: widget.dW,
      //                   tS: widget.tS,
      //                   chatText:
      //                       'Yes its been going fun.I know how well the show was recieved by the public its really bad going.',
      //                   dateTime: '12:31',
      //                   isDelieverd: true,
      //                   byUser: false),
      //               ChatText(
      //                 chatText: 'Yes the book has been going really well.',
      //                 dW: widget.dW,
      //                 dateTime: '11:09',
      //                 isDelieverd: true,
      //                 byUser: true,
      //                 tS: widget.tS,
      //               ),
      //               ChatText(
      //                 chatText: 'duh',
      //                 dW: widget.dW,
      //                 dateTime: '11:09',
      //                 isDelieverd: true,
      //                 byUser: true,
      //                 tS: widget.tS,
      //               ),
      //               const Spacer(),
      //             ]),
      //       ),
      //       SizedBox(
      //         width: widget.dW,
      //         child: Row(children: [
      //           const Spacer(),
      //           Container(
      //             width: widget.dW * 0.8,
      //             decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(24)),
      //             child: TextFormField(
      //               minLines: 1,
      //               maxLines: 5,
      //               cursorColor: Colors.amber,
      //               style: TextStyle(fontSize: 18 * widget.tS),
      //               decoration: const InputDecoration(
      //                   hintText: 'Message',
      //                   border: InputBorder.none,
      //                   prefixIcon: Icon(
      //                     Icons.emoji_emotions_outlined,
      //                     color: Colors.red,
      //                   ),
      //                   suffixIcon: Icon(
      //                     Icons.browse_gallery,
      //                     color: Colors.red,
      //                   )),
      //             ),
      //           ),
      //           const Spacer(),
      //           CircleAvatar(
      //             backgroundColor: Colors.red,
      //             radius: widget.dW * 0.07,
      //             child: const Center(
      //                 child: Icon(
      //               Icons.send,
      //               color: Colors.white,
      //             )),
      //           ),
      //         ]),
      //       ),
      //       SizedBox(height: widget.dW * 0.01)
      //     ],
      //   ),
      // ),
    );
  }
}
