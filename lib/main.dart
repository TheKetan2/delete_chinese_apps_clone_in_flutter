import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delete China Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Delete China Apps'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isAwesome = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2da8bb),
        title: Text(widget.title),
        elevation: 1,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: _isAwesome
                    ? Image.asset(
                        "assets/success.png",
                        height: 150,
                        width: 150,
                      )
                    : Image.asset(
                        "assets/dragon.png",
                        height: 150,
                        width: 150,
                      ),
              ),
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.ac_unit),
                    title: Text("HI"),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                itemCount: 10,
              ),
            )),
            RaisedButton(
              padding: EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 15,
              ),
              child: Text(
                "SCAN NOW",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Color(0xff2da8bb),
              onPressed: () {
                setState(() {
                  _isAwesome = !_isAwesome;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
