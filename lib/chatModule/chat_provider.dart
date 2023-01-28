import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:heda_saathi/authModule/providers/auth_provider.dart';
import 'package:heda_saathi/chatModule/chat_model.dart';
import 'package:provider/provider.dart';

import '../authModule/models/user_modal.dart';

class ChatProvider with ChangeNotifier {
  List<Chat> _chats = [];

  List<Chat> get chats => _chats;



  //loadChats
  loadUserChats(
    {
      required List<String> chatIds,
      required String accessToken,
      required String userId,
    }
  ) {
    //get all the chats
    //extract them into chat class by using userId sort the chat of user and other user.
    //load them into _chats. 

  }

  








  //sendText
  sendText(
    {
     required String chatId,
     required String text,
    }
  ){

  }

}
