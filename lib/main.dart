import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer' as devtools show log ;
extension Log on Object{
void log () => devtools.log(toString());
}

void main() {
  runApp(const MyApp());
}

void testit ()async{
 final stream1 =  Stream.periodic(Duration(seconds: 1),(count) => 'Stream1,count:$count');
 final stream2 = Stream.periodic(Duration(seconds: 3),(count) => 'Stream2,count:$count');
final combined =  Rx.combineLatest2(stream1, stream2, (one,two) => 'One is $one,Two is $two');
await for (final value in combined){
  print(value);
value.log();
}
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)  {
    testit();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Simple Scaffold App")),
        body: Center(child: Text("Hello, Flutter!")),
      ),
    );
  }
}
