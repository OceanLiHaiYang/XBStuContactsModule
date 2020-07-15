import 'dart:async';
import 'package:XBFlutterSourceModule/simple_page_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(FlutterView());
}

class FlutterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter View',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<MyHomePage> {
//  对应swift中的FlutterMethodChannel
  static const platform = const MethodChannel('https://www.xiaoyukeji.cn');
  String message = 'null message';

  // 注册一个通知
  static const EventChannel eventChannel =
      const EventChannel('https://www.xiaoyukeji1.cn');
  String naviTitle = 'title';

  // 渲染前的操作，类似viewDidLoad
  @override
  void initState() {
    super.initState();
    print('initStateed ----------');
  }

  void _eventHandle() {
    // 监听事件，同时发送参数eventChannel
    eventChannel
        .receiveBroadcastStream('eventChannel')
        .listen(_onEvent, onError: _onError);
  }

  // 回调事件
  void _onEvent(Object event) {
    setState(() {
      naviTitle = event.toString();
    });
  }

  // 错误返回
  void _onError(Object error) {}

  void _getNativeMessage() async {
    String result;
    try {
      // swift回调中对应的”约定” : getFlutterMessage,[1,2,3]:传递参数
      result = await platform.invokeMethod('callNativeMethond', [1, 2, 3]);
    } on PlatformException catch (e) {
      result = "error message $e";
    }
    setState(() {
      message = result;
    });
  }

  void _getNativePush() async {
    String result;
    try {
      // OC回调中对应的”约定” : getFlutterMessage,[1,2,3]:传递参数
      result = await platform.invokeMethod('pushNewPage', [1, 2, 3]);
    } on PlatformException catch (e) {
      result = "error message $e";
    }
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      // body: Center(
      //   child: RaisedButton(
      //     child: const Text('Open second route'),
      //     onPressed: () {
      //       print('open second page!');
      //       FlutterBoost.singleton
      //           .open('second')
      //           .then((Map<dynamic, dynamic> value) {
      //         print(
      //             'call me when page is finished. did recieve second route result $value');
      //       });
      //     },
      //   ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('MethodChannel: get message'),
              onPressed: () {
                // 点击按钮发送消息给swift
                _getNativeMessage();
              },
            ),
            // swift接收到消息之后,会回调一个值过来显示
            Text(message),

            RaisedButton(
              child: Text('EventChannel: recive event'),
              onPressed: () {
                // 点击按钮发送消息给swift
                _eventHandle();
              },
            ),
            // swift接收到消息之后,会回调一个值过来显示
            Text('EventChannel: $naviTitle'),
            RaisedButton(
              onPressed: () {
                ///路由跳转
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return new SecondRouteWidget();
                }));
              },
              child: Text("flutter跳转第二个页面"),
            ),
            RaisedButton(
              onPressed: () {
                ///路由跳转
                _getNativePush();
              },
              child: Text("native跳转第二个页面"),
            ),
          ],
        ),
      ),
    );
  }
}
/************************ home *****************************/
// class _MyHomePageState extends State<MyHomePage> {
//   static const String _channel = 'increment';
//   static const String _pong = 'pong';
//   static const String _emptyMessage = '';
//   static const BasicMessageChannel<String> platform =
//       BasicMessageChannel<String>(_channel, StringCodec());

//   int _counter = 0;

//   @override
//   void initState() {
//     super.initState();
//     platform.setMessageHandler(_handlePlatformIncrement);
//   }

//   Future<String> _handlePlatformIncrement(String message) async {
//     setState(() {
//       _counter++;
//     });
//     return _emptyMessage;
//   }

//   void _sendFlutterIncrement() {
//     platform.send(_pong);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Expanded(
//             child: Center(
//               child: Text(
//                 'Platform button tapped $_counter time${ _counter == 1 ? '' : 's' }.',
//                 style: const TextStyle(fontSize: 17.0)),
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
//             child: Row(
//               children: <Widget>[
//                 Image.asset('assets/flutter-mark-square-64.png', scale: 1.5),
//                 const Text('Flutter', style: TextStyle(fontSize: 30.0)),
//               ],
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _sendFlutterIncrement,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
/*********************flutter boost*********************/
// import 'package:flutter/material.dart';
// import 'package:flutter_boost/flutter_boost.dart';
// import 'simple_page_widgets.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();

//     FlutterBoost.singleton.registerPageBuilders(<String, PageBuilder>{
//       'first': (String pageName, Map<String, dynamic> params, String _) =>
//           FirstRouteWidget(),
//       'second': (String pageName, Map<String, dynamic> params, String _) =>
//           SecondRouteWidget(),
//       'tab': (String pageName, Map<String, dynamic> params, String _) =>
//           TabRouteWidget(),
//       'flutterFragment':
//           (String pageName, Map<String, dynamic> params, String _) =>
//               FragmentRouteWidget(params),

//       ///可以在native层通过 getContainerParams 来传递参数
//       'flutterPage': (String pageName, Map<String, dynamic> params, String _) {
//         print('flutterPage params:$params');

//         return const FlutterRouteWidget();
//       },
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Boost example',
//       builder: FlutterBoost.init(postPush: _onRoutePushed),
//       home: Container(),
//     );
//   }

//   void _onRoutePushed(
//     String pageName,
//     String uniqueId,
//     Map<String, dynamic> params,
//     Route<dynamic> route,
//     Future<dynamic> _,
//   ) {}
// }
