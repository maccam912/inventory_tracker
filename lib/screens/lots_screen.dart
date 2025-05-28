import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import '../database/database.dart';
import '../database/database_provider.dart';

class LotsScreen extends StatefulWidget {
  const LotsScreen({Key? key}) : super(key: key);

  @override
  _LotsScreenState createState() => _LotsScreenState();
}

class _LotsScreenState extends State<LotsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _lotNumberController = TextEditingController();
  DateTime? _selectedExpirationDate;

  @override
  void dispose() {
    _lotNumberController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'No expiration date';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectExpirationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedExpirationDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)), // 10 years from now
    );
    if (picked != null && picked != _selectedExpirationDate) {
      setState(() {
        _selectedExpirationDate = picked;
      });
    }
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
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectExpirationDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _formatDate(_selectedExpirationDate),
                                  style: TextStyle(
                                    color: _selectedExpirationDate == null 
                                        ? Colors.grey[600] 
                                        : Colors.black,
                                  ),
                                ),
                                const Icon(Icons.calendar_today, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
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
                      subtitle: Text('Expires: ${_formatDate(lot.expirationDate)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await database.deleteLot(lot.id);
                          setState(() {});
                        },
                      ),
                      onTap: () {
                        // Edit lot dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            final editController = TextEditingController(text: lot.lotNumber);
                            DateTime? editExpirationDate = lot.expirationDate;
                            
                            return StatefulBuilder(
                              builder: (context, setDialogState) {
                                return AlertDialog(
                                  title: const Text('Edit Lot'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: editController,
                                        decoration: const InputDecoration(
                                          labelText: 'Lot Number',
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      InkWell(
                                        onTap: () async {
                                          final DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: editExpirationDate ?? DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime.now().add(const Duration(days: 3650)),
                                          );
                                          if (picked != null) {
                                            setDialogState(() {
                                              editExpirationDate = picked;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(_formatDate(editExpirationDate)),
                                              const Icon(Icons.calendar_today, color: Colors.grey),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setDialogState(() {
                                                editExpirationDate = null;
                                              });
                                            },
                                            child: const Text('Clear Date'),
                                          ),
                                        ],
                                      ),
                                    ],
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
                                          Navigator.pop(context);
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
