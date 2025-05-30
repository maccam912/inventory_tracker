import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import '../database/database.dart';
import '../database/database_provider.dart';

class LotsScreen extends StatefulWidget {
  const LotsScreen({super.key});

  @override
  LotsScreenState createState() => LotsScreenState();
}

class LotsScreenState extends State<LotsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lotNumberController = TextEditingController();
  DateTime? _selectedExpirationDate;

  @override
  void dispose() {
    _lotNumberController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectExpirationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedExpirationDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365 * 10),
      ), // 10 years from now
    );
    if (picked != null && picked != _selectedExpirationDate) {
      setState(() {
        _selectedExpirationDate = picked;
      });
    }
  }

  void _showEditLotDialog(BuildContext context, Lot lot, AppDatabase database) {
    final editController = TextEditingController(text: lot.lotNumber);
    DateTime? editExpirationDate = lot.expirationDate;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Lot'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: editController,
                      decoration: const InputDecoration(
                        labelText: 'Lot Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: editExpirationDate ?? DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 10),
                          ),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            editExpirationDate = picked;
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Expiration Date (Optional)',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                editExpirationDate != null
                                    ? _formatDate(editExpirationDate)
                                    : 'Tap to select date',
                                style: editExpirationDate != null
                                    ? null
                                    : TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                            if (editExpirationDate != null)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setDialogState(() {
                                    editExpirationDate = null;
                                  });
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (editController.text.isNotEmpty) {
                      await database.updateLot(
                        lot.copyWith(
                          lotNumber: editController.text,
                          expirationDate: Value(editExpirationDate),
                        ),
                      );
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      setState(() {});
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
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
                        child: TextFormField(
                          controller: _lotNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Lot Number',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a lot number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectExpirationDate(context),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Expiration Date (Optional)',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            child: Text(
                              _selectedExpirationDate != null
                                  ? _formatDate(_selectedExpirationDate)
                                  : 'Tap to select date',
                              style: _selectedExpirationDate != null
                                  ? null
                                  : TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ),
                      if (_selectedExpirationDate != null)
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _selectedExpirationDate = null;
                            });
                          },
                        ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await database.insertLot(
                              LotsCompanion.insert(
                                lotNumber: _lotNumberController.text,
                                expirationDate: _selectedExpirationDate != null
                                    ? Value(_selectedExpirationDate!)
                                    : const Value.absent(),
                              ),
                            );
                            _lotNumberController.clear();
                            _selectedExpirationDate = null;
                            setState(() {});
                          }
                        },
                        child: const Text('Add Lot'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Lot>>(
              future: database.getAllLots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final lots = snapshot.data ?? [];

                if (lots.isEmpty) {
                  return const Center(child: Text('No lots added yet'));
                }

                return ListView.builder(
                  itemCount: lots.length,
                  itemBuilder: (context, index) {
                    final lot = lots[index];
                    return ListTile(
                      title: Text(lot.lotNumber),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          lot.expirationDate != null
                              ? Text(
                                  'Expires: ${_formatDate(lot.expirationDate)}',
                                )
                              : const Text('No expiration date'),
                          Text(lot.isActive ? 'Active' : 'Inactive'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Switch(
                            value: lot.isActive,
                            onChanged: (value) async {
                              await database.updateLot(
                                lot.copyWith(isActive: value),
                              );
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await database.deleteLot(lot.id);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        _showEditLotDialog(context, lot, database);
                      },
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
}
