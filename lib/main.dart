import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:uninstall_apps/uninstall_apps.dart';
import "./apps.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  bool _isAwesome = false;
  bool _isSearched = false;
  bool _isLoading = false;
  List<Application> deviceApps;

  _removeApp(int index) async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      deviceApps.removeAt(index);
    });

    if (deviceApps.length == 0) {
      setState(() {
        _isAwesome = true;
      });
    }
  }

  _unInstallApp(String pkg) async {
    await UninstallApps.uninstall(pkg);
  }

  _scanForApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: false,
    );

    List<Application> tempApps = [];

    for (int i = 0; i < apps.length; i++) {
      if (chineseApps.contains(apps[i].packageName)) {
        print(apps[i].packageName);
        // apps.removeAt(i);
        tempApps.add(apps[i]);
      }
    }

    setState(() {
      deviceApps = tempApps;
      _isLoading = false;
      _isSearched = true;
    });

    // print(deviceApps[0].appName);
  }

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
              width: double.infinity,
              child: _isAwesome
                  ? Center(
                      child: Container(
                        child: Text(
                          "You are awesome, No China Apps found",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black45,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : !_isSearched
                      ? Center(
                          child: Container(
                            child: Text(
                              "Scan For Chinese Apps",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.black45,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            Application app = deviceApps[index];
                            // print("${index} : " + app.packageName);
                            return ListTile(
                              contentPadding: EdgeInsets.all(8),
                              leading: app is ApplicationWithIcon
                                  ? CircleAvatar(
                                      backgroundImage: MemoryImage(app.icon),
                                      backgroundColor: Colors.white,
                                    )
                                  : null,
                              title: Text(app.appName),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _unInstallApp(deviceApps[index].packageName);
                                  _removeApp(index);
                                },
                              ),
                            );
                          },
                          itemCount: deviceApps.length,
                        ),
            )),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
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
                _scanForApps();
                setState(() {
                  _isLoading = true;
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
