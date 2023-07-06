import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'func_file.dart';
import 'class_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'first_step',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 34, 248, 255)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  List<User> _searchResult = [];
  List<User> _users = [];
  void initState() {
    super.initState();
    readJsonData();
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _users.forEach((user) {
      if (user.userName!.contains(text) || user.lastMessage!.contains(text)) {
        _searchResult.add(user);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 20, 121, 222),
          title: const Text('Telegram', style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        drawer: Drawer(
          //backgroundColor: Colors.white,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Sasha Dokanin',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: Text('+7(950)-228-13-37'),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('src/avatars/13.jpg'),
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 20, 121, 222),
                ),
              ),
              ListTile(
                leading: Icon(Icons.group_outlined),
                title: const Text(
                  'Создать группу',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: const Text(
                  'Контакты',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.phone_outlined),
                title: const Text(
                  'Звонки',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.person_search_outlined),
                title: const Text(
                  'Люди рядом',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.bookmark_add_outlined),
                title: const Text(
                  'Избранное',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.settings_outlined),
                title: const Text(
                  'Настройки',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.person_add_outlined),
                title: const Text(
                  'Пригласить друзей',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.question_mark_outlined),
                title: const Text(
                  'Возможности Telegram',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: readJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var users = data.data as List<User>;
              users.removeWhere((user) => user.lastMessage == null);
              return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: setAvatar(users[index]),
                      title: Text(
                        overflow: TextOverflow.ellipsis,
                        users[index].userName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(users[index].lastMessage.toString(),
                          overflow: TextOverflow.ellipsis),
                      onTap: () {},
                      trailing: setTrail(users[index]),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
