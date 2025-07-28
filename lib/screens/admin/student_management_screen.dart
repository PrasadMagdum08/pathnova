import 'package:flutter/material.dart';

class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() => _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  TextEditingController _searchController = TextEditingController();

  List<String> allBatches = [
    "Batch Jan'24", "Batch Feb'24", "Batch Mar'24", "Batch Apr'24",
    "Batch May'24", "Batch Jun'24", "Batch July'24", "Batch Aug'24",
    "Batch Sept'24", "Batch Sept'25", "Batch Sept'26", "Batch Sept'23"
  ];

  List<String> filteredBatches = [];

  @override
  void initState() {
    super.initState();
    filteredBatches = List.from(allBatches);
    _searchController.addListener(_filterBatches);
  }

  void _filterBatches() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredBatches = allBatches
          .where((batch) => batch.toLowerCase().contains(query))
          .toList();
    });
  }

  void _onBatchTap(String batch) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(batch)),
          body: Center(child: Text("Student list for $batch")),
        ),
      ),
    );
  }

  Widget _buildBatchCard(String batch) {
    return GestureDetector(
      onTap: () => _onBatchTap(batch),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(batch, style: const TextStyle(fontSize: 14)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Management"),
        backgroundColor: Colors.black87,
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 12),
          Icon(Icons.account_circle),
          SizedBox(width: 12),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Text('PathNova Admin', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            ListTile(leading: Icon(Icons.dashboard), title: Text('Dashboard')),
            ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFEDEDED),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Batch ...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 16),
            // 📦 Batches Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.8,
                children: filteredBatches.map(_buildBatchCard).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
