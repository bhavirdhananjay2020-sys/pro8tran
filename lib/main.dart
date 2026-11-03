import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
const navy = Color(0xFF101F3B);
const orange = Color(0xFFF28C28);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kqxkbopijippzrtrmann.supabase.co',
    publishableKey: 'sb_publishable_VTxsrq7edNlo-Wa1e_rskw_4-4_fVhJ',
  );

  runApp(const Routex89App());
}

class Routex89App extends StatelessWidget {
  const Routex89App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'ROUTEX89',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: navy, primary: navy, secondary: orange),
      scaffoldBackgroundColor: const Color(0xFFF4F6FA),
      appBarTheme: const AppBarTheme(backgroundColor: navy, foregroundColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        filled: true, fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    ),
    home: const MainShell(),
  );
}

class Load {
  Load(this.from, this.to, this.vehicle, this.goods, this.freight);
  final String from, to, vehicle, goods;
  final double freight;
}

class Vehicle {
  Vehicle(this.number, this.type, this.source);
  final String number, type, source;
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final loads = <Load>[];
  final vehicles = <Vehicle>[
    Vehicle('MH 04 AB 1234', '20 ft Container', 'Own Fleet'),
    Vehicle('MH 04 CD 5678', '32 ft MXL', 'Own Fleet'),
    Vehicle('MH 04 EF 9012', '32 ft SXL', 'Market Vehicle'),
  ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      Dashboard(loads: loads, vehicles: vehicles, go: (i) => setState(() => index = i)),
      LoadsScreen(loads: loads, add: (v) => setState(() => loads.insert(0, v))),
      FleetScreen(vehicles: vehicles, add: (v) => setState(() => vehicles.add(v))),
      const BusinessScreen(),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('ROUTEX89', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.3))),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index, onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.local_shipping_outlined), label: 'Loads'),
          NavigationDestination(icon: Icon(Icons.local_shipping_outlined), label: 'Fleet'),
          NavigationDestination(icon: Icon(Icons.business_outlined), label: 'Business'),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key, required this.loads, required this.vehicles, required this.go});
  final List<Load> loads; final List<Vehicle> vehicles; final ValueChanged<int> go;
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [navy, Color(0xFF263F68)]), borderRadius: BorderRadius.circular(20)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Moving India Forward.', style: TextStyle(color: Colors.white70)),
        SizedBox(height: 8),
        Text('Your transport business,\\none smart platform.', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10), Text('Freight • Fleet • Trips • Business', style: TextStyle(color: Colors.white70)),
      ]),
    ),
    const SizedBox(height: 16),
    Row(children: [
      Expanded(child: Metric(label: 'Demo Loads', value: '${loads.length}', icon: Icons.inventory_2_outlined)),
      const SizedBox(width: 12),
      Expanded(child: Metric(label: 'Vehicles', value: '${vehicles.length}', icon: Icons.local_shipping_outlined)),
    ]),
    const SizedBox(height: 20),
    const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 10),
    Wrap(spacing: 10, runSpacing: 10, children: [
      Quick(label: 'Post a Load', icon: Icons.add_box_outlined, tap: () => go(1)),
      Quick(label: 'Manage Fleet', icon: Icons.local_shipping_outlined, tap: () => go(2)),
      Quick(label: 'Business', icon: Icons.account_balance_wallet_outlined, tap: () => go(3)),
    ]),
    const SizedBox(height: 20),
    const Text('Recent Loads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    const SizedBox(height: 8),
    if (loads.isEmpty) const Text('No loads yet. Use Post a Load to create a demo load.')
    else ...loads.take(4).map((l) => LoadTile(load: l)),
    const SizedBox(height: 18),
    const Text('Prototype only: data is stored in memory and resets when the app restarts.', style: TextStyle(color: Colors.black54, fontSize: 12)),
  ]);
}

class Metric extends StatelessWidget {
  const Metric({super.key, required this.label, required this.value, required this.icon});
  final String label, value; final IconData icon;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: orange), const SizedBox(height: 8),
      Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: navy)),
      Text(label, style: const TextStyle(color: Colors.black54)),
    ]));
}

class Quick extends StatelessWidget {
  const Quick({super.key, required this.label, required this.icon, required this.tap});
  final String label; final IconData icon; final VoidCallback tap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: tap, child: Container(
    width: 145, padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: orange, size: 26), const SizedBox(height: 10),
      Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    ])));
}

class LoadsScreen extends StatelessWidget {
  const LoadsScreen({super.key, required this.loads, required this.add});
  final List<Load> loads; final ValueChanged<Load> add;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.transparent,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: orange, foregroundColor: navy, icon: const Icon(Icons.add), label: const Text('Post Load'),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddLoad(add: add))),
    ),
    body: loads.isEmpty ? const Center(child: Text('No demo loads posted yet.'))
      : ListView(padding: const EdgeInsets.all(14), children: loads.map((l) => LoadTile(load: l)).toList()),
  );
}

class AddLoad extends StatefulWidget {
  const AddLoad({super.key, required this.add});
  final ValueChanged<Load> add;
  @override
  State<AddLoad> createState() => _AddLoadState();
}

class _AddLoadState extends State<AddLoad> {
  final form = GlobalKey<FormState>();
  final from = TextEditingController(), to = TextEditingController(), goods = TextEditingController(), freight = TextEditingController();
  String vehicle = '20 ft Container';
  @override
  void dispose() { from.dispose(); to.dispose(); goods.dispose(); freight.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Post a Load')),
    body: Form(key: form, child: ListView(padding: const EdgeInsets.all(16), children: [
      field(from, 'Pickup city / location'),
      field(to, 'Delivery city / location'),
      field(goods, 'Goods description'),
      DropdownButtonFormField<String>(
        value: vehicle, decoration: const InputDecoration(labelText: 'Vehicle type'),
        items: const ['Pickup', '14 ft Closed Container', '17 ft Closed Container', '20 ft Container', '22 ft Container', '24 ft Container', '32 ft SXL', '32 ft MXL', 'Open Body']
          .map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => vehicle = v ?? vehicle)),
      const SizedBox(height: 12), field(freight, 'Expected freight (₹)', numeric: true),
      const SizedBox(height: 18),
      FilledButton(style: FilledButton.styleFrom(backgroundColor: orange, foregroundColor: navy, padding: const EdgeInsets.all(16)),
        onPressed: () {
          if (!form.currentState!.validate()) return;
          widget.add(Load(from.text.trim(), to.text.trim(), vehicle, goods.text.trim(), double.parse(freight.text.trim())));
          Navigator.pop(context);
        }, child: const Text('Save Demo Load')),
      const SizedBox(height: 10),
      const Text('This is a local demo. It does not publish a live freight request.', style: TextStyle(color: Colors.black54, fontSize: 12)),
    ])),
  );
  Widget field(TextEditingController c, String label, {bool numeric = false}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(controller: c, keyboardType: numeric ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (v) => v == null || v.trim().isEmpty ? 'Required' : (numeric && double.tryParse(v) == null ? 'Enter a valid amount' : null)),
  );
}

class LoadTile extends StatelessWidget {
  const LoadTile({super.key, required this.load});
  final Load load;
  @override
  Widget build(BuildContext context) => Card(color: Colors.white, elevation: 0, child: Padding(
    padding: const EdgeInsets.all(14), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('${load.from}  →  ${load.to}', style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 5), Text('${load.vehicle} • ${load.goods}'),
      const SizedBox(height: 5), Text('₹${load.freight.toStringAsFixed(0)}', style: const TextStyle(color: navy, fontWeight: FontWeight.bold, fontSize: 18)),
    ])));
}

class FleetScreen extends StatelessWidget {
  const FleetScreen({super.key, required this.vehicles, required this.add});
  final List<Vehicle> vehicles; final ValueChanged<Vehicle> add;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.transparent,
    floatingActionButton: FloatingActionButton.extended(
      backgroundColor: orange, foregroundColor: navy, icon: const Icon(Icons.add), label: const Text('Add Vehicle'),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddVehicle(add: add))),
    ),
    body: ListView(padding: const EdgeInsets.all(14), children: [
      const Text('Own + Market Fleet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      ...vehicles.map((v) => Card(color: Colors.white, elevation: 0, child: ListTile(
        leading: const Icon(Icons.local_shipping, color: orange),
        title: Text(v.number, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${v.type} • ${v.source}'),
      ))),
    ]),
  );
}

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key, required this.add});
  final ValueChanged<Vehicle> add;
  @override
  State<AddVehicle> createState() => _AddVehicleState();
}
class _AddVehicleState extends State<AddVehicle> {
  final number = TextEditingController();
  String type = '20 ft Container', source = 'Own Fleet';
  @override
  void dispose() { number.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add Vehicle')),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      TextField(controller: number, textCapitalization: TextCapitalization.characters, decoration: const InputDecoration(labelText: 'Vehicle registration number')),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(value: type, decoration: const InputDecoration(labelText: 'Vehicle type'),
        items: const ['Pickup', '20 ft Container', '32 ft SXL', '32 ft MXL', 'Open Body'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => type = v ?? type)),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(value: source, decoration: const InputDecoration(labelText: 'Fleet source'),
        items: const ['Own Fleet', 'Market Vehicle'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => source = v ?? source)),
      const SizedBox(height: 18),
      FilledButton(style: FilledButton.styleFrom(backgroundColor: orange, foregroundColor: navy),
        onPressed: () { if (number.text.trim().isEmpty) return; widget.add(Vehicle(number.text.trim().toUpperCase(), type, source)); Navigator.pop(context); },
        child: const Text('Save Vehicle')),
    ]),
  );
}

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: const [
    Text('Business Workspace', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    SizedBox(height: 12),
    BusinessRow(icon: Icons.receipt_long, title: 'LR & Documents', detail: 'Next build milestone'),
    BusinessRow(icon: Icons.account_balance_wallet_outlined, title: 'Income & Expenses', detail: 'Trip-wise ledger — next milestone'),
    BusinessRow(icon: Icons.payments_outlined, title: 'Driver Settlement', detail: 'Manual review before automation'),
    BusinessRow(icon: Icons.location_on_outlined, title: 'GPS Tracking', detail: 'Phase 2 — with driver consent'),
    SizedBox(height: 16),
    Text('ROUTEX89 Android MVP • Prototype v0.1.0', style: TextStyle(color: Colors.black54)),
  ]);
}

class BusinessRow extends StatelessWidget {
  const BusinessRow({super.key, required this.icon, required this.title, required this.detail});
  final IconData icon; final String title, detail;
  @override
  Widget build(BuildContext context) => Card(color: Colors.white, elevation: 0, child: ListTile(
    leading: Icon(icon, color: orange), title: Text(title), subtitle: Text(detail), trailing: const Icon(Icons.lock_clock, size: 18)));
}
