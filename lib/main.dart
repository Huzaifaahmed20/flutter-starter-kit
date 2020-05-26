import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/PostsProvider/PostProvider.dart';
import './provider/PostsProvider/PostsModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Starter Kit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider.value(
        value: PostProvider(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<PostProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Starter Kit'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder(
          future: post.fetchPosts(),
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (ctx, idx) {
                  final PostsModel post = snap.data[idx];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('${post.title}'),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
