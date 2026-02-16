// bin/dev_server.dart
import 'dart:io';

import '../server/api_server.dart';

void main() async {
  const targetPort = 5967;

  print('🔍 Checking port $targetPort...');

  // Auto-kill if port is in use
  if (await _isPortInUse(targetPort)) {
    print('⚠️  Port $targetPort is busy, attempting to free it...');
    await _killPort(targetPort);
    await Future.delayed(const Duration(seconds: 1));

    // Check again
    if (await _isPortInUse(targetPort)) {
      print('❌ Could not free port $targetPort. Please manually run:');
      print('   taskkill /F /IM dart.exe');
      exit(1);
    }
    print('✅ Port $targetPort is now free');
  }

  // Start unified server
  final server = UnifiedServer(port: targetPort);
  await server.start();

  print('');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('🌐 http://localhost:$targetPort/');
  print('🔌 http://localhost:$targetPort/api/');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');

  // Keep alive
  ProcessSignal.sigint.watch().listen((_) async {
    print('\n🛑 Shutting down...');
    await server.stop();
    exit(0);
  });

  await Future.delayed(Duration(days: 365));
}

Future<bool> _isPortInUse(int port) async {
  try {
    final socket = await ServerSocket.bind('localhost', port);
    await socket.close();
    return false; // Port is free
  } catch (_) {
    return true; // Port is in use
  }
}

Future<void> _killPort(int port) async {
  if (Platform.isWindows) {
    // Method 1: Find by port and kill
    try {
      final result = await Process.run('cmd', [
        '/c',
        'for /f "tokens=5" %a in (\'netstat -ano ^| findstr ":$port" ^| findstr "LISTENING"\') do @taskkill /F /PID %a 2>nul',
      ], runInShell: true);
      print('   Killed processes on port $port');
    } catch (_) {}

    // Method 2: Kill all dart processes (backup)
    try {
      await Process.run('taskkill', [
        '/F',
        '/IM',
        'dart.exe',
        '/T',
      ], runInShell: true);
      print('   Killed dart.exe processes');
    } catch (_) {}

    // Method 3: Kill all flutter processes
    try {
      await Process.run('taskkill', [
        '/F',
        '/IM',
        'flutter.bat',
        '/T',
      ], runInShell: true);
    } catch (_) {}
  } else {
    // macOS/Linux
    await Process.run('sh', [
      '-c',
      'lsof -ti:$port | xargs kill -9 2>/dev/null || true',
    ]);
  }
}
