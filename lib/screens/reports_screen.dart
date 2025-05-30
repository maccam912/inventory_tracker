import 'package:flutter/material.dart';
import 'package:inventory_tracker/database/database.dart';
import 'package:inventory_tracker/database/database_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  ReportsScreenState createState() => ReportsScreenState();
}

class ReportsScreenState extends State<ReportsScreen> {
  late AppDatabase database;
  bool _isLotReport = true; // true for Lot Report, false for Site Report
  int? _selectedLotId;
  int? _selectedSiteId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    database = DatabaseProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Report Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Lot Report'),
                            subtitle: const Text(
                              'Shows inventory of a specific lot across all active sites',
                            ),
                            value: true,
                            groupValue: _isLotReport,
                            onChanged: (value) {
                              setState(() {
                                _isLotReport = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            title: const Text('Site Report'),
                            subtitle: const Text(
                              'Shows latest inventory for all active lots at a specific site',
                            ),
                            value: false,
                            groupValue: _isLotReport,
                            onChanged: (value) {
                              setState(() {
                                _isLotReport = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    if (_isLotReport)
                      _buildLotSelector()
                    else
                      _buildSiteSelector(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            _isLotReport ? _buildLotReportContent() : _buildSiteReportContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildLotSelector() {
    return Row(
      children: [
        Expanded(
          child: FutureBuilder<List<Lot>>(
            future: database.getActiveLots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final lots = snapshot.data ?? [];

              if (lots.isEmpty) {
                return const Text(
                  'No active lots available. Add lots and mark them as active.',
                );
              }

              return DropdownButtonFormField<int>(
                value: _selectedLotId,
                decoration: const InputDecoration(
                  labelText: 'Select Lot',
                  border: OutlineInputBorder(),
                ),
                items: lots.map((lot) {
                  return DropdownMenuItem(
                    value: lot.id,
                    child: Text(lot.lotNumber),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedLotId = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSiteSelector() {
    return Row(
      children: [
        Expanded(
          child: FutureBuilder<List<Site>>(
            future: database.getActiveSites(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              final sites = snapshot.data ?? [];

              if (sites.isEmpty) {
                return const Text(
                  'No active sites available. Add sites and mark them as active.',
                );
              }

              return DropdownButtonFormField<int>(
                value: _selectedSiteId,
                decoration: const InputDecoration(
                  labelText: 'Select Site',
                  border: OutlineInputBorder(),
                ),
                items: sites.map((site) {
                  return DropdownMenuItem(
                    value: site.id,
                    child: Text(site.siteName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSiteId = value;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLotReportContent() {
    if (_selectedLotId == null) {
      return const Center(
        child: Text('Please select a lot to view the report'),
      );
    }

    return Expanded(
      child: FutureBuilder<List<InventorySnapshotWithDetails>>(
        future: database.getInventoryByLotAcrossSites(_selectedLotId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final inventoryList = snapshot.data ?? [];

          if (inventoryList.isEmpty) {
            return const Center(
              child: Text('No inventory data found for the selected lot.'),
            );
          }

          // Get the lot number for the title
          final lotNumber = inventoryList.first.lot.lotNumber;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inventory for Lot: $lotNumber',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: inventoryList.length,
                  itemBuilder: (context, index) {
                    final item = inventoryList[index];
                    return Card(
                      child: ListTile(
                        title: Text(item.site.siteName),
                        subtitle: Text(
                          'Count: ${item.snapshot.count} (${_formatDate(item.snapshot.timestamp)})',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSiteReportContent() {
    if (_selectedSiteId == null) {
      return const Center(
        child: Text('Please select a site to view the report'),
      );
    }

    return Expanded(
      child: FutureBuilder<List<InventorySnapshotWithDetails>>(
        future: database.getLatestInventoryForSite(_selectedSiteId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final inventoryList = snapshot.data ?? [];

          if (inventoryList.isEmpty) {
            return const Center(
              child: Text('No inventory data found for the selected site.'),
            );
          }

          // Get the site name for the title
          final siteName = inventoryList.first.site.siteName;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Latest Inventory for Site: $siteName',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: inventoryList.length,
                  itemBuilder: (context, index) {
                    final item = inventoryList[index];
                    return Card(
                      child: ListTile(
                        title: Text(item.lot.lotNumber),
                        subtitle: Text(
                          'Count: ${item.snapshot.count} (${_formatDate(item.snapshot.timestamp)})',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}
