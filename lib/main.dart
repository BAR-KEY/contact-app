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
  @override
  void initState() {
    super.initState();
    // makeCount();
  }

  int a = 1;
  List<Contact> name = [];
  List<int> count = [0, 0, 0, 0];
  String inputName = '';
  // List<String> phoneNumber = [
  //   '010' + (Random().nextInt(89999999) + 10000000).toString(),
  //   '010' + (Random().nextInt(89999999) + 10000000).toString(),
  //   '010' + (Random().nextInt(89999999) + 10000000).toString(),
  //   '010' + (Random().nextInt(89999999) + 10000000).toString(),
  // ];
  // String inputPhoneNumber = '';

  // addData(enterName, enterPhoneNumber) {
  addData(enterName) {
    setState(() {
      count.add(0);
      name.add(enterName);
      // phoneNumber.add(enterPhoneNumber.toString());
    });
  }

  add() {
    setState(() {
      a++;
    });
    return a;
  }

  delete(deleteName) {
    setState(() {
      name.removeAt(deleteName);
    });
  }

  // makeCount() {
  //   setState(() {
  //     for (int i = 0; i < name.length - 1; i++) {
  //       count.add(0);
  //     }
  //   });
  // }

  getPermission() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      print('허락됨');
      var contacts = await ContactsService.getContacts();
      print(contacts);
      setState(() {
        name = contacts;
      });
      // var nerPerson = Contact();
      // nerPerson.givenName = 'test';
      // await ContactsService.addContact(nerPerson);
      // 연락처에 추가하는법.
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
            flex: 2,
            child: Text(
              '추가한 친구수 ' + a.toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: () {
                // setState(() {
                // name.givenName.sort((a, b) => a.compareTo(b));
                // });
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text(
                '이름순 오름차순',
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: () {
                setState(() {
                  // name.givenName.sort((a, b) => b.compareTo(a));
                });
              },
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text(
                '이름순 내림차순',
              ),
            ),
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
                // Expanded(flex: 3, child: Text(phoneNumber[i])),
                Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: () {
                        delete(i);
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
            // inputPhoneNumber: inputPhoneNumber,
            addData: addData);
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
      this.inputPhoneNumber,
      this.addData})
      : super(key: key);
  final a, name, add, count, inputPhoneNumber, addData;
  var inputName;

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
                        // TextField(
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     labelText: '전화번호를 입력하세요.',
                        //   ),
                        //   onChanged: (text) {
                        //     inputPhoneNumber = int.parse(text);
                        //   },
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel')),
                            TextButton(
                                onPressed: () {
                                  add();
                                  // addData(inputName);
                                  var newContact = Contact();
                                  newContact.givenName = inputName;
                                  ContactsService.addContact(newContact);
                                  addData(newContact);
                                  // if (inputPhoneNumber is int) {
                                  // addData(inputName, inputPhoneNumber);
                                  // }

                                  Navigator.pop(context);
                                },
                                child: Text('OK')),
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
