import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> items = [
    {"title": "Title A", "content": "Content 1"},
    {"title": "Title B", "content": "Content 2"},
    {"title": "Title C", "content": "Content 3"},
    {"title": "Title D", "content": "Content 4"},
    {"title": "Title E", "content": "Content 5"},
    {"title": "Title F", "content": "Content 6"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dismissible'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Dismissible(
            key: Key(item['title']),
            /* onDismissedの中にスワイプされた時の処理を書く */
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });

              if (direction == DismissDirection.endToStart) {
                /* スワイプ方向がendToStart（画面左から右）の場合の処理 */
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("削除しました"),
                  ),
                );
              } else {
                /* スワイプ方向がstartToEnd（画面右から左）の場合の処理 */
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("登録しました"),
                  ),
                );
              }
            },
            /* スワイプ方向がendToStart（画面左から右）の場合のバックグラウンド処理 */
            background: Container(
              alignment: Alignment.centerLeft,
              color: Colors.greenAccent[700],
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: Icon(Icons.thumb_up, color: Colors.white)),
            ),
            // スワイプ方向がstartToEnd（画面右から左）の場合のバックグラウンドの設定
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
            ),
            child: Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text(item['title'] + '：' + item['content']),
              ),
            ),
          );
        },
      ),
    );
  }
}
