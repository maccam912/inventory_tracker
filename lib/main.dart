import 'package:flutter/material.dart';
import 'database/database.dart';
import 'database/database_provider.dart';
import 'screens/home_screen.dart';
import 'settings/deletion_settings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  final deletionSettings = DeletionSettings();

  runApp(
    DatabaseProvider(
      database: database,
      child: DeletionSettingsProvider(
        settings: deletionSettings,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Tracker',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Color(0xFF8A5CF6), // Lighter purple for primary elements
          onPrimary: Color(0xFF1A0F2E), // Dark text on primary
          secondary: Color(0xFF6366F1), // Indigo-blue accent
          onSecondary: Color(0xFF1A0F2E), // Dark text on secondary
          tertiary: Color(0xFF8B5DFF), // Bright purple accent
          onTertiary: Color(0xFF1A0F2E), // Dark text on tertiary
          surface: Color(0xFF1A0F2E), // Dark purple surface
          onSurface: Color(0xFFE5DEFF), // Light purple text on dark surface
          surfaceContainerHighest: Color(
            0xFF2D1B3D,
          ), // Slightly lighter surface
          onSurfaceVariant: Color(
            0xFFD0BCFF,
          ), // Muted light purple for secondary text
          outline: Color(0xFF6B46C1), // Purple outline color
          error: Color(0xFFFF6B9D), // Pink-purple error color
          onError: Color(0xFF1A0F2E), // Dark text on error
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
