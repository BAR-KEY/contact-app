import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
// import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Contact> contacts = [];
  @override
  void initState() {
    super.initState();
    getPermission();
  }

  int a = 1;
  List<Contact> name = [];
  List<int> count = [];
  String inputName = '';
  String inputNumber = '';

  // addData(enterName, enterNumber) {
  //   setState(() {
  //     count.add(0);
  //     name.add(enterName);
  //   });
  // }

  add() {
    setState(() {
      a++;
    });
    return a;
  }

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      List<Contact> _contacts = await ContactsService.getContacts();
      contacts = _contacts;
      setState(() {
        name = contacts;
      });
      for (int i = 0; i < name.length; i++) {
        if (i < name.length) {
          count.add(0);
        }
      }
    } else if (status.isDenied) {
      print('거절됨');
      Permission.contacts.request();
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              '추가한 친구수 ' + a.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: () {
                print(count);
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text(
                'test',
              ),
            ), //
          ),
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    getPermission();
                  },
                  icon: Icon(Icons.contacts))),
        ],
      )),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (c, i) {
          return ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(count[i].toString()),
                ),
                Expanded(flex: 2, child: Text(name[i].givenName ?? 'null')),
                // Expanded(
                //     flex: 3,
                //     child: Text(name[i].phones?.elementAt(0).toString())),
                Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: () {
                        ContactsService.deleteContact(name[i]);
                        getPermission();
                      },
                      child: Text('삭제'),
                    )),
                Expanded(
                  flex: 2,
                  child: TextButton(
                    child: Text('좋아요'),
                    onPressed: () {
                      setState(() {
                        count[i]++;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigator(),
      floatingActionButton: Builder(builder: (context) {
        return DialogUI(
          a: a,
          name: name,
          add: add,
          count: count,
          inputName: inputName,
          inputNumber: inputNumber,
          getPermission: getPermission,
          // addData: addData
        );
      }),
    ));
  }
}

class DialogUI extends StatelessWidget {
  DialogUI(
      {Key? key,
      this.a,
      this.name,
      this.add,
      this.count,
      this.inputName,
      this.inputNumber,
      this.addData,
      this.getPermission})
      : super(key: key);
  final a, name, add, count, addData;
  var inputName, inputNumber, getPermission;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Text('추가'),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    child: SizedBox(
                  width: 400,
                  height: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '이름을 입력하세요.',
                          ),
                          onChanged: (text) {
                            inputName = text;
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '번호를 입력하세요.',
                          ),
                          onChanged: (text) {
                            inputNumber = text;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('취소')),
                            TextButton(
                                onPressed: () {
                                  add();
                                  var newContact = Contact();
                                  newContact.givenName = inputName;
                                  ContactsService.addContact(newContact);
                                  count.add(0);
                                  // addData(newContact);
                                  Navigator.pop(context);
                                  getPermission();
                                },
                                child: Text('완료')),
                          ],
                        ),
                        Text(a.toString())
                      ],
                    ),
                  ),
                ));
              });
        });
  }
}

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Icon(Icons.phone, size: 30.0),
        Icon(Icons.message, size: 30.0),
        Icon(Icons.file_copy, size: 30.0),
      ]),
    );
  }
}
