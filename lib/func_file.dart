import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'class_user.dart';
import 'dart:math';

setAvatar(User user) {
  Random random = Random();
  if (user.userAvatar != null) {
    return CircleAvatar(
      backgroundImage: AssetImage('src/avatars/' + user.userAvatar.toString()),
    );
  } else {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: SizedBox(
        width: 40,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(
                    random.nextInt(255),
                    random.nextInt(255),
                    random.nextInt(255),
                    1,
                  ),
                  Colors.white
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              )),
          child: Center(
            child: Text(
              user.userName.toString()[0],
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}

setTrail(User user) {
  if (user.countUnreadMessages! > 0) {
    return Column(
      children: [
        // индикатор непрочитанных сообщений
        Container(
          width: 24,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color.fromARGB(255, 122, 194, 227),
          ),
          child: Center(
            child: Text(
              user.countUnreadMessages.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
        getDate(user.date!),
      ],
    );
  } else {
    getDate(user.date!);
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

getDate(int takenDate) {
  String date = DateTime.fromMillisecondsSinceEpoch(takenDate).toString();
  if (daysBetween(
          DateTime.fromMillisecondsSinceEpoch(takenDate), DateTime.now()) ==
      0) {
    return Text(date[11] + date[12] + date[13] + date[14] + date[15]);
  } else if (daysBetween(
          DateTime.fromMillisecondsSinceEpoch(takenDate), DateTime.now()) <=
      7) {
    return Text(
        DateTime.fromMillisecondsSinceEpoch(takenDate).weekday.toString());
  } else {
    return Text(DateFormat.MMMMd()
        .format(DateTime.fromMillisecondsSinceEpoch(takenDate))
        .toString());
  }
}
