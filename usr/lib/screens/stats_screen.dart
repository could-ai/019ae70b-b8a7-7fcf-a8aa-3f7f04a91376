import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Statistiques'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              children: [
                Expanded(child: _buildStatCard(context, '7', 'Jours d\'affilée', Icons.local_fire_department, Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard(context, '12', 'Fiches révisées', Icons.check_circle, Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            
            const Text('Progression par matière', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  _buildProgressRow('Mathématiques', 0.75, Colors.blue),
                  _buildProgressRow('Histoire', 0.45, Colors.red),
                  _buildProgressRow('Anglais', 0.90, Colors.purple),
                  _buildProgressRow('Géographie', 0.30, Colors.green),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            const Text('Activité Récente', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade50,
                      child: const Icon(Icons.quiz, color: Colors.deepPurple, size: 20),
                    ),
                    title: const Text('Quiz Mathématiques'),
                    subtitle: const Text('Score: 8/10 • Il y a 2h'),
                    trailing: const Text('+50 xp', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      child: const Icon(Icons.style, color: Colors.blue, size: 20),
                    ),
                    title: const Text('Flashcards Anglais'),
                    subtitle: const Text('20 cartes étudiées • Hier'),
                    trailing: const Text('+30 xp', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                   ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.green.shade50,
                      child: const Icon(Icons.description, color: Colors.green, size: 20),
                    ),
                    title: const Text('Fiche Révolution'),
                    subtitle: const Text('Lecture complète • Hier'),
                    trailing: const Text('+10 xp', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildProgressRow(String label, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
              Text('${(progress * 100).toInt()}%', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.shade100,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
