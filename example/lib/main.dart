import 'package:flutter/material.dart';
import 'package:anti_screenshot_guard/anti_screenshot_guard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anti Screenshot Guard Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  bool _isEnabled = false;
  String _status = 'Protection disabled';

  @override
  void initState() {
    super.initState();
    AntiScreenshotGuard.addScreenshotListener(_onScreenshot);
  }

  @override
  void dispose() {
    AntiScreenshotGuard.removeScreenshotListener(_onScreenshot);
    super.dispose();
  }

  void _onScreenshot() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Screenshot detected!')),
    );
  }

  void _toggleProtection() async {
    if (_isEnabled) {
      await AntiScreenshotGuard.disable();
      setState(() {
        _isEnabled = false;
        _status = 'Protection disabled';
      });
    } else {
      await AntiScreenshotGuard.enable();
      setState(() {
        _isEnabled = true;
        _status = 'Protection enabled';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anti Screenshot Guard Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _status,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleProtection,
              child:
                  Text(_isEnabled ? 'Disable Protection' : 'Enable Protection'),
            ),
            const SizedBox(height: 40),
            const Text(
                'Try taking a screenshot to see the detection in action.'),
            const SizedBox(height: 20),
            SecureScreen(
              enableProtection: _isEnabled,
              blurOnScreenshot: true,
              onScreenshot: () {
                debugPrint('Screenshot taken from SecureScreen!');
              },
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    'Secure Content',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
