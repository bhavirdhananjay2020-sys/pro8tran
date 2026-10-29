import 'package:flutter/material.dart';

void main() => runApp(const Pro8TranApp());

const navy = Color(0xFF073763);
const orange = Color(0xFFFF8A1F);

class Pro8TranApp extends StatelessWidget {
  const Pro8TranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro8Tran',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: navy, primary: navy, secondary: orange),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: navy, foregroundColor: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pro8Tran'), subtitle: const Text('by SwifPace X Logistics Pvt Ltd')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: navy, borderRadius: BorderRadius.circular(20)),
            child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Truck booking, made transparent.', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('A starter MVP for customers, truck partners and operations admins.', style: TextStyle(color: Colors.white70)),
            ]),
          ),
          const SizedBox(height: 18),
          _HomeTile(icon: Icons.local_shipping, title: 'Customer: Book a Truck', subtitle: 'Search route, select vehicle and create a demo booking', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookingScreen()))),
          _HomeTile(icon: Icons.fire_truck, title: 'Truck Partner Registration', subtitle: 'Add owner, vehicle, driver and bank details', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnerScreen()))),
          _HomeTile(icon: Icons.admin_panel_settings, title: 'Admin Dashboard', subtitle: 'Review demo bookings, charges and settlements', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminScreen()))),
          const SizedBox(height: 10),
          const Card(child: Padding(padding: EdgeInsets.all(14), child: Text('DEMO ONLY: Information is kept in app memory and will reset when the app restarts. No real booking, KYC verification, GPS tracking or payment is performed.'))),
        ],
      ),
    );
  }
}

class _HomeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _HomeTile({required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: ListTile(leading: CircleAvatar(backgroundColor: orange.withValues(alpha: .18), child: Icon(icon, color: navy)), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_right), onTap: onTap),
  );
}

class DemoStore {
  static final List<Map<String, String>> bookings = [];
  static final List<Map<String, String>> partners = [];
}

const vehicleTypes = <String>[
  'Pickup', '407 / 14 ft Container — 3 ton class', '17 ft Container — 4 ton class',
  '20 ft Container — 6 ton class', '22 ft Container — 9 ton class',
  '24 ft Container — 9 ton class', '32 ft MXL Container', '32 ft SXL Container',
  '20 ft Open — 10 MT class', '22 ft Open — 12 MT class', '24 ft Open — 18 MT class',
  '28 ft Open — 25 MT class', '30 ft Open — 30 MT class',
];

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final formKey = GlobalKey<FormState>();
  final company = TextEditingController();
  final from = TextEditingController();
  final to = TextEditingController();
  final freight = TextEditingController();
  String vehicle = vehicleTypes.first;
  String payment = 'Pay SwifPace (demo)';

  @override
  void dispose() { company.dispose(); from.dispose(); to.dispose(); freight.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Book a Truck')),
    body: Form(key: formKey, child: ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Booking details', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
      const SizedBox(height: 14),
      _field(company, 'Customer / Company name'),
      const SizedBox(height: 12), _field(from, 'Pickup city / address'),
      const SizedBox(height: 12), _field(to, 'Delivery city / address'),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(value: vehicle, isExpanded: true, decoration: const InputDecoration(labelText: 'Vehicle type'), items: vehicleTypes.map((v) => DropdownMenuItem(value: v, child: Text(v, overflow: TextOverflow.ellipsis))).toList(), onChanged: (v) => setState(() => vehicle = v ?? vehicle)),
      const SizedBox(height: 12), _field(freight, 'Agreed freight (₹)', numeric: true),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(value: payment, decoration: const InputDecoration(labelText: 'Payment preference'), items: const [DropdownMenuItem(value: 'Pay SwifPace (demo)', child: Text('Pay SwifPace (demo)')), DropdownMenuItem(value: 'Direct payment (demo)', child: Text('Direct payment (demo)'))], onChanged: (v) => setState(() => payment = v ?? payment)),
      const SizedBox(height: 18),
      FilledButton.icon(onPressed: () {
        if (!formKey.currentState!.validate()) return;
        DemoStore.bookings.add({'company': company.text.trim(), 'from': from.text.trim(), 'to': to.text.trim(), 'vehicle': vehicle, 'freight': freight.text.trim(), 'payment': payment, 'status': 'Booking requested'});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo booking created. No real truck is booked.')));
        Navigator.pop(context);
      }, icon: const Icon(Icons.search), label: const Text('Create Demo Booking')),
    ])),
  );
}

Widget _field(TextEditingController c, String label, {bool numeric = false}) => TextFormField(
  controller: c, keyboardType: numeric ? TextInputType.number : TextInputType.text,
  decoration: InputDecoration(labelText: label), validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter $label' : null,
);

class PartnerScreen extends StatefulWidget {
  const PartnerScreen({super.key});
  @override
  State<PartnerScreen> createState() => _PartnerScreenState();
}

class _PartnerScreenState extends State<PartnerScreen> {
  final formKey = GlobalKey<FormState>();
  final owner = TextEditingController(); final phone = TextEditingController(); final reg = TextEditingController(); final driver = TextEditingController(); final bank = TextEditingController();
  String vehicle = vehicleTypes.first;
  @override
  void dispose() { owner.dispose(); phone.dispose(); reg.dispose(); driver.dispose(); bank.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Truck Partner')), body: Form(key: formKey, child: ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Partner registration (demo)', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
    const SizedBox(height: 14), _field(owner, 'Owner / company name'), const SizedBox(height: 12), _field(phone, 'Contact number', numeric: true), const SizedBox(height: 12),
    DropdownButtonFormField<String>(value: vehicle, isExpanded: true, decoration: const InputDecoration(labelText: 'Vehicle type'), items: vehicleTypes.map((v) => DropdownMenuItem(value: v, child: Text(v, overflow: TextOverflow.ellipsis))).toList(), onChanged: (v) => setState(() => vehicle = v ?? vehicle)),
    const SizedBox(height: 12), _field(reg, 'Vehicle registration number'), const SizedBox(height: 12), _field(driver, 'Driver name'), const SizedBox(height: 12), _field(bank, 'Bank account holder name (do not enter account number in this demo)'),
    const SizedBox(height: 10), const Text('Production version will need secure document upload and verified KYC. Do not upload real identity or bank documents into this demo.', style: TextStyle(color: Colors.redAccent)),
    const SizedBox(height: 16), FilledButton(onPressed: () { if (!formKey.currentState!.validate()) return; DemoStore.partners.add({'owner': owner.text.trim(), 'phone': phone.text.trim(), 'vehicle': vehicle, 'registration': reg.text.trim(), 'driver': driver.text.trim(), 'bankName': bank.text.trim(), 'status': 'Pending verification'}); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo partner profile saved. Not KYC verified.'))); Navigator.pop(context); }, child: const Text('Save Demo Partner')),
  ])));
}

class AdminScreen extends StatefulWidget { const AdminScreen({super.key}); @override State<AdminScreen> createState() => _AdminScreenState(); }
class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Admin Dashboard')), body: ListView(padding: const EdgeInsets.all(16), children: [
    GridView.count(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisCount: 2, childAspectRatio: 1.45, crossAxisSpacing: 10, mainAxisSpacing: 10, children: [
      _metric('Bookings', '${DemoStore.bookings.length}', Icons.local_shipping), _metric('Partners', '${DemoStore.partners.length}', Icons.people), _metric('Pending KYC', '${DemoStore.partners.length}', Icons.verified_user), _metric('Settlement due', '₹ —', Icons.currency_rupee),
    ]),
    const SizedBox(height: 18), const Text('Recent bookings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    if (DemoStore.bookings.isEmpty) const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No demo bookings yet. Create one from the Customer screen.'))),
    ...DemoStore.bookings.reversed.map((b) => Card(child: ListTile(title: Text('${b['from']} → ${b['to']}'), subtitle: Text('${b['company']} • ${b['vehicle']}\nFreight: ₹${b['freight']} • ${b['payment']}'), isThreeLine: true, trailing: const Chip(label: Text('Requested'))))),
    const SizedBox(height: 18), const Text('Truck partners', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    if (DemoStore.partners.isEmpty) const Card(child: Padding(padding: EdgeInsets.all(16), child: Text('No demo partners yet.'))),
    ...DemoStore.partners.reversed.map((p) => Card(child: ListTile(leading: const Icon(Icons.local_shipping), title: Text(p['owner'] ?? ''), subtitle: Text('${p['registration']} • ${p['vehicle']}\nDriver: ${p['driver']}'), isThreeLine: true, trailing: const Chip(label: Text('Pending KYC'))))),
    const SizedBox(height: 14), const Text('Production admin must use role-based login, secure backend storage, audit logs and server-side financial calculations.', style: TextStyle(color: Colors.black54)),
  ]));
}
Widget _metric(String label, String value, IconData icon) => Card(child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Icon(icon, color: orange), Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), Text(label)])));
