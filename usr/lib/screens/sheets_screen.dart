import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class SheetsScreen extends StatelessWidget {
  const SheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Fiches de Révision'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockSheets.length,
        itemBuilder: (context, index) {
          final sheet = mockSheets[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(Icons.description, color: Theme.of(context).primaryColor),
              ),
              title: Text(sheet.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(sheet.subject),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SheetDetailScreen(sheet: sheet),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SheetDetailScreen extends StatelessWidget {
  final StudySheet sheet;

  const SheetDetailScreen({super.key, required this.sheet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sheet.subject),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sheet.title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Text(
                sheet.content,
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
