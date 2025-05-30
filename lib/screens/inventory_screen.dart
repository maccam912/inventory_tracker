import 'package:flutter/material.dart';
import '../database/database.dart';
import '../database/database_provider.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  InventoryScreenState createState() => InventoryScreenState();
}

class InventoryScreenState extends State<InventoryScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedSiteId;
  int? _selectedLotId;
  final _countController = TextEditingController();

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = DatabaseProvider.of(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<Site>>(
                          future: database.getAllSites(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            final sites = snapshot.data ?? [];

                            if (sites.isEmpty) {
                              return const Text(
                                'No sites available. Add sites first.',
                              );
                            }

                            return DropdownButtonFormField<int>(
                              value: _selectedSiteId,
                              decoration: const InputDecoration(
                                labelText: 'Site',
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
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a site';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: FutureBuilder<List<Lot>>(
                          future: database.getAllLots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            final lots = snapshot.data ?? [];

                            if (lots.isEmpty) {
                              return const Text(
                                'No lots available. Add lots first.',
                              );
                            }

                            return DropdownButtonFormField<int>(
                              value: _selectedLotId,
                              decoration: const InputDecoration(
                                labelText: 'Lot',
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
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a lot';
                                }
                                return null;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _countController,
                          decoration: const InputDecoration(
                            labelText: 'Count',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a count';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await database.insertInventorySnapshot(
                              InventorySnapshotsCompanion.insert(
                                siteId: _selectedSiteId!,
                                lotId: _selectedLotId!,
                                count: int.parse(_countController.text),
                              ),
                            );
                            _countController.clear();
                            setState(() {});
                          }
                        },
                        child: const Text('Add Inventory'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<InventorySnapshotWithDetails>>(
              future: database.getAllInventorySnapshotsWithDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final snapshots = snapshot.data ?? [];

                if (snapshots.isEmpty) {
                  return const Center(
                    child: Text('No inventory data added yet'),
                  );
                }

                return ListView.builder(
                  itemCount: snapshots.length,
                  itemBuilder: (context, index) {
                    final inventoryData = snapshots[index];
                    return ListTile(
                      title: Text(
                        '${inventoryData.site.siteName} - ${inventoryData.lot.lotNumber}',
                      ),
                      subtitle: Text('Count: ${inventoryData.snapshot.count}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Date: ${_formatDate(inventoryData.snapshot.timestamp)}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await database.deleteInventorySnapshot(
                                inventoryData.snapshot.id,
                              );
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}
