import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class User {
  String? userName;
  String? lastMessage;
  int? date;
  String? userAvatar;
  int? countUnreadMessages;

  User({
    this.userName,
    this.lastMessage,
    this.date,
    this.userAvatar,
    this.countUnreadMessages,
  });

  User.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    lastMessage = json['lastMessage'];
    date = json['date'];
    userAvatar = json['userAvatar'];
    countUnreadMessages = json['countUnreadMessages'];
  }
}

Future<List<User>> readJsonData() async {
  final jsondata = await rootBundle.rootBundle.loadString('src/bootcamp.json');
  final list = json.decode(jsondata) as List<dynamic>;

  return list.map((e) => User.fromJson(e)).toList();
}
