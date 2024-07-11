import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:joblookup/pages/graph/view_db_graph.dart';
import 'package:joblookup/pages/home/home_form_page.dart';
import 'package:joblookup/pages/views/view_database.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:window_manager/window_manager.dart';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  sqfliteFfiInit();

  WidgetsFlutterBinding.ensureInitialized();
  // if it's not on the web, windows or android, load the accent color
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    if (defaultTargetPlatform == TargetPlatform.windows) {
      await flutter_acrylic.Window.hideWindowControls();
    }
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setMinimumSize(const Size(812, 600));
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Job Lookup',
      debugShowCheckedModeBanner: false,
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.standard,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedWindow = 0;
  void selectWindow(int index) {
    setState(() {
      selectedWindow = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
        title: Text('Job Lookups and Graphs'),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        onChanged: selectWindow,
        selected: selectedWindow,
        displayMode: PaneDisplayMode.compact,
        items: [
          PaneItem(
            title: const Text("Home"),
            icon: const Icon(Icons.home),
            body: const HomeBody(),
          ),
          PaneItem(
            title: const Text("View"),
            icon: const Icon(Icons.view_list),
            body: const ViewTheDatabase(),
          ),
          PaneItem(
            title: const Text("Graph"),
            icon: const Icon(Icons.graphic_eq),
            body: const ViewTheDatabaseGraph(),
          ),
        ],
      ),
    );
  }
}

class WindowBody extends StatefulWidget {
  const WindowBody({super.key});

  @override
  State<WindowBody> createState() => _WindowBodyState();
}

class _WindowBodyState extends State<WindowBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
