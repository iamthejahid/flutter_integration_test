import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _textEditingController.clear();
    super.initState();
  }

  void _incrementCounter() {
    if (_textEditingController.text.isNotEmpty) {
      _formKey.currentState!.validate();
    }
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MySecondPage(
            title: _textEditingController.text,
          ),
        ),
      );
    }
  }

  // @override
  // void dispose() {
  //   _textEditingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                  key: _formKey,
                  child: TextFormField(
                    key: const Key('text_field_key'),
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'P u t   y o u r   t e x t   h e r e!',
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? 'You can not leave this empty'
                        : null,
                  )),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

class MySecondPage extends StatefulWidget {
  const MySecondPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MySecondPage> createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            // This need to be handled more programatic way!
            // pardon my lazy working style and amateur dirty code!

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(
                  title: 'Flutter Demo Home Page',
                ),
              ),
            );
          },
        ),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.title),
          ],
        ),
      ),
    );
  }
}
