import 'package:flutter/material.dart';
import 'package:newscast/pager.dart';
import 'package:newscast/screens/notifier.dart';
import 'package:newscast/services/news.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>MyChangeNotifier()),
        StreamProvider<SharedPreferences?>.value(
          value: SharedPreferences.getInstance().asStream(),
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'News Cast',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Pager(),
      ),
    );
  }
}
