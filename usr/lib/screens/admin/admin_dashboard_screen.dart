import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADMIN PANEL'),
        backgroundColor: const Color(0xFF1A1A2E),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar (visible on larger screens, or use drawer on mobile)
          if (MediaQuery.of(context).size.width > 600)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: const Color(0xFF1A1A2E),
              selectedIconTheme: const IconThemeData(color: Color(0xFFFF4655)),
              unselectedIconTheme: const IconThemeData(color: Colors.grey),
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(color: Color(0xFFFF4655)),
              unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.people),
                  label: Text('Users'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.games),
                  label: Text('Games'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.payments),
                  label: Text('Transactions'),
                ),
              ],
            ),
          
          // Main Content Area
          Expanded(
            child: Container(
              color: const Color(0xFF0F1923),
              padding: const EdgeInsets.all(16),
              child: _buildContent(_selectedIndex),
            ),
          ),
        ],
      ),
      drawer: MediaQuery.of(context).size.width <= 600
          ? Drawer(
              backgroundColor: const Color(0xFF1A1A2E),
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: Center(
                      child: Text(
                        'ADMIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dashboard, color: Colors.grey),
                    title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
                    onTap: () => setState(() { _selectedIndex = 0; Navigator.pop(context); }),
                  ),
                  ListTile(
                    leading: const Icon(Icons.people, color: Colors.grey),
                    title: const Text('Users', style: TextStyle(color: Colors.white)),
                    onTap: () => setState(() { _selectedIndex = 1; Navigator.pop(context); }),
                  ),
                  ListTile(
                    leading: const Icon(Icons.games, color: Colors.grey),
                    title: const Text('Games', style: TextStyle(color: Colors.white)),
                    onTap: () => setState(() { _selectedIndex = 2; Navigator.pop(context); }),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return _buildDashboardStats();
      case 1:
        return _buildUserTable();
      case 2:
        return _buildGamesManagement();
      default:
        return const Center(child: Text('Coming Soon'));
    }
  }

  Widget _buildDashboardStats() {
    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _buildStatCard('Total Users', '1,234', Icons.people, Colors.blue),
        _buildStatCard('Active Bets', '56', Icons.casino, Colors.orange),
        _buildStatCard('Revenue', '₹ 45K', Icons.attach_money, Colors.green),
        _buildStatCard('Pending Withdrawals', '12', Icons.warning, Colors.red),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      color: const Color(0xFF1F2937),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTable() {
    return Card(
      color: const Color(0xFF1F2937),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.black12),
          columns: const [
            DataColumn(label: Text('ID', style: TextStyle(color: Colors.white))),
            DataColumn(label: Text('Name', style: TextStyle(color: Colors.white))),
            DataColumn(label: Text('Phone', style: TextStyle(color: Colors.white))),
            DataColumn(label: Text('Balance', style: TextStyle(color: Colors.white))),
            DataColumn(label: Text('Status', style: TextStyle(color: Colors.white))),
            DataColumn(label: Text('Actions', style: TextStyle(color: Colors.white))),
          ],
          rows: List.generate(10, (index) {
            return DataRow(
              cells: [
                DataCell(Text('#100${index + 1}', style: const TextStyle(color: Colors.grey))),
                DataCell(Text('User ${index + 1}', style: const TextStyle(color: Colors.white))),
                DataCell(Text('987654321$index', style: const TextStyle(color: Colors.grey))),
                DataCell(Text('₹ ${(index + 1) * 500}', style: const TextStyle(color: Colors.greenAccent))),
                DataCell(Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: index % 3 == 0 ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    index % 3 == 0 ? 'Banned' : 'Active',
                    style: TextStyle(
                      color: index % 3 == 0 ? Colors.red : Colors.green,
                      fontSize: 12,
                    ),
                  ),
                )),
                DataCell(Row(
                  children: [
                    IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 20), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () {}),
                  ],
                )),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildGamesManagement() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: const Color(0xFF1F2937),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              color: Colors.black26,
              child: const Icon(Icons.videogame_asset, color: Colors.white),
            ),
            title: Text('Game Name ${index + 1}', style: const TextStyle(color: Colors.white)),
            subtitle: const Text('Category: Slots', style: TextStyle(color: Colors.grey)),
            trailing: Switch(
              value: index % 2 == 0,
              onChanged: (val) {},
              activeColor: const Color(0xFFFF4655),
            ),
          ),
        );
      },
    );
  }
}
