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
  var a = 1;
  var name = ['김영숙', '홍길동', '피자집', '박희문'];
  var inputData = '';
  var count = [0, 0, 0, 0];

  // var count = makeCount();

  // makeCount() => setState(() {
  //       for (var i = 0; i < name.length; i++) {
  //         count.add('0');
  //       }
  //     });
// 해야할것 !
  addData(enterName) {
    if (enterName.length > 0) {
      setState(() {
        name.add(enterName);
        count.add(0);
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
            a.toString(),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            child: Text(
              '이름순 정렬',
            ),
          )
        ],
      )),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: Text(count[i].toString()),
            title: Row(
              children: [
                Text(name[i]),
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
            inputData: inputData,
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
      this.inputData,
      this.addData})
      : super(key: key);
  var a, name, add, count, inputData, addData;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Text('hi'),
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
                            labelText: 'EnterName',
                          ),
                          onChanged: (text) {
                            inputData = text;
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
                                  addData(inputData);
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
