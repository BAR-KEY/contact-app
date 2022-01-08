import 'dart:math';
import 'package:flutter/material.dart';

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
  // ignore: must_call_super
  void didChangeDependencies() {
    makeCount() {
      setState(() {
        for (var i = 0; i < name.length - 1; i++) {
          count.add(0);
        }
      });
    }

    makeCount();
  }

  var a = 1;
  var name = [
    '가나다',
    '사아자',
    '차카타',
    '라마바',
  ];
  var phoneNumber = [
    '010' + (Random().nextInt(89999999) + 10000000).toString(),
    '010' + (Random().nextInt(89999999) + 10000000).toString(),
    '010' + (Random().nextInt(89999999) + 10000000).toString(),
    '010' + (Random().nextInt(89999999) + 10000000).toString(),
  ];
  var count = [0];
  var inputName = '';
  var inputPhoneNumber = '';

  addData(enterName, enterPhoneNumber) {
    if (enterName.length > 0) {
      setState(() {
        name.add(enterName);
        count.add(0);
        phoneNumber.add(enterPhoneNumber.toString());
        // if (enterPhoneNumber is int) {
        //   phoneNumber.add(enterPhoneNumber.toString());
        // } else {
        //   Navigator.pop(context);
        // }
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          Text(
            '추가한 친구수 ' + a.toString(),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                name.sort((a, b) => a.compareTo(b));
              });
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            child: Text(
              '이름순 오름차순',
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                name.sort((a, b) => b.compareTo(a));
              });
            },
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            child: Text(
              '이름순 내림차순',
            ),
          ),
        ],
      )),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: Text(count[i].toString()),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(width: 100, height: 30, child: Text(name[i])),
                Text(phoneNumber[i]),
                TextButton(
                  onPressed: () {
                    delete(i);
                  },
                  child: Text('삭제'),
                )
              ],
            ),
            trailing: TextButton(
              child: Text('좋아요'),
              onPressed: () {
                setState(() {
                  count[i]++;
                });
              },
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
            inputPhoneNumber: inputPhoneNumber,
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
  var a, name, add, count, inputName, inputPhoneNumber, addData;

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
                            labelText: '전화번호를 입력하세요.',
                          ),
                          onChanged: (text) {
                            inputPhoneNumber = int.parse(text);
                          },
                        ),
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
                                  if (inputPhoneNumber is int) {
                                    addData(inputName, inputPhoneNumber);
                                  }

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
