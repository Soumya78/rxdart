import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final subject = useMemoized(() => BehaviorSubject<String>(), [key]);
    useEffect(() => subject.close, [subject]);
    return Scaffold(
      appBar: AppBar(title: StreamBuilder(
          stream: subject.distinct().debounceTime(const Duration(seconds: 1)),
          initialData: 'Please start typing',
          builder: (context,snapshot){
            return Text(snapshot.requireData);
          },),),
      body: TextField(
        onChanged: (string) {
          subject.sink.add(string);
        },
      ),
    );
  }
}
