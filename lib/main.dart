import 'package:flutter/material.dart';

void main() {
  runApp(const BingwaApp());
}

class BingwaApp extends StatelessWidget {
  const BingwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bingwa Data Swift',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedNetwork = 'Safaricom';
  String selectedBundle = '1GB - Ksh 100';

  final Map<String, List<String>> bundles = {
    'Safaricom': ['1GB - Ksh 100', '2GB - Ksh 180', '5GB - Ksh 400', '10GB - Ksh 800'],
    'Airtel': ['1GB - Ksh 90', '2GB - Ksh 160', '5GB - Ksh 350', '10GB - Ksh 700'],
    'Telkom': ['1GB - Ksh 80', '2GB - Ksh 150', '5GB - Ksh 300', '10GB - Ksh 600'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bingwa Data Swift'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Chagua Network', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: selectedNetwork,
              isExpanded: true,
              items: bundles.keys.map((n) => DropdownMenuItem(value: n, child: Text(n))).toList(),
              onChanged: (v) {
                setState(() {
                  selectedNetwork = v!;
                  selectedBundle = bundles[v]!.first;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Chagua Bundle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...bundles[selectedNetwork]!.map((b) => Card(
              color: selectedBundle == b ? Colors.green.shade100 : Colors.white,
              child: ListTile(
                title: Text(b),
                leading: Radio<String>(
                  value: b,
                  groupValue: selectedBundle,
                  onChanged: (v) => setState(() => selectedBundle = v!),
                ),
                onTap: () => setState(() => selectedBundle = b),
              ),
            )),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.all(16)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Umechagua $selectedBundle - $selectedNetwork')),
                );
              },
              child: const Text('Nunua Sasa', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
