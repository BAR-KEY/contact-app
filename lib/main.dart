import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('금호동3가 >'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => {},
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => {},
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.alarm),
                  onPressed: () => {},
                  color: Colors.black,
                ),
              ],
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            body: Container(
              height: 150,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Image.asset(
                    'assets/doge.png',
                    width: 150,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Doge 코인 팝니다.',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20)),
                            Text('달서구 도원동 . 끌올 10분 전',
                                style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 151, 151, 151))),
                            Text('203원',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Icon(Icons.favorite), Text('4')],
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.orange,
                ),
              ),
            )));
  }
}
