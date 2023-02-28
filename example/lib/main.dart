import 'package:flutter/cupertino.dart';

import 'battery_gauge_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: StartWidget(), //MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class StartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Animated Battery Demo'),
      ),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (context) {
                    return BatteryGaugeDemo(
                      isHorizontal: true,
                      isGrid: false,
                    );
                  }));
                },
                child: Text('Show Battery Horizontal w/ gauge'),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (context) {
                    return BatteryGaugeDemo(
                      isHorizontal: false,
                      isGrid: false,
                    );
                  }));
                },
                child: Text('Show Battery Vertical w/ gauge'),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (context) {
                    return BatteryGaugeDemo(
                      isHorizontal: true,
                      isGrid: true,
                    );
                  }));
                },
                child: Text('Show Battery Horizontal w/ grid mode'),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (context) {
                    return BatteryGaugeDemo(
                      isHorizontal: false,
                      isGrid: true,
                    );
                  }));
                },
                child: Text('Show Battery Vertical w/ grid mode'),
              ),
            ]),
      ),
    );
  }
}
