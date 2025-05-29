import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
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

  String _formatDate(DateTime? date) {
    if (date == null) return 'No expiration date';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
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
                              _formatDate(_selectedExpirationDate),
                              style: TextStyle(
                                color: _selectedExpirationDate == null
                                    ? Colors.grey
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_selectedExpirationDate != null) ...[
                        const SizedBox(width: 8.0),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _selectedExpirationDate = null;
                            });
                          },
                          tooltip: 'Clear date',
                        ),
                      ],
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
                                    ? drift.Value(_selectedExpirationDate)
                                    : const drift.Value.absent(),
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
                      subtitle: Text(
                        'Expires: ${_formatDate(lot.expirationDate)}',
                        style: TextStyle(
                          color:
                              lot.expirationDate != null &&
                                  lot.expirationDate!.isBefore(DateTime.now())
                              ? Colors.red
                              : Colors.grey[600],
                        ),
                      ),
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
                          builder: (context) => _EditLotDialog(
                            lot: lot,
                            onSave: (updatedLot) async {
                              await database.updateLot(updatedLot);
                              setState(() {});
                            },
                          ),
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

class _EditLotDialog extends StatefulWidget {
  final Lot lot;
  final Function(Lot) onSave;

  const _EditLotDialog({required this.lot, required this.onSave});

  @override
  _EditLotDialogState createState() => _EditLotDialogState();
}

class _EditLotDialogState extends State<_EditLotDialog> {
  late final TextEditingController _editController;
  DateTime? _selectedExpirationDate;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.lot.lotNumber);
    _selectedExpirationDate = widget.lot.expirationDate;
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }

  Future<void> _selectExpirationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedExpirationDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null && picked != _selectedExpirationDate) {
      setState(() {
        _selectedExpirationDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'No expiration date';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Lot'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _editController,
            decoration: const InputDecoration(
              labelText: 'Lot Number',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () => _selectExpirationDate(context),
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
                      _formatDate(_selectedExpirationDate),
                      style: TextStyle(
                        color: _selectedExpirationDate == null
                            ? Colors.grey
                            : null,
                      ),
                    ),
                  ),
                  if (_selectedExpirationDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () {
                        setState(() {
                          _selectedExpirationDate = null;
                        });
                      },
                      tooltip: 'Clear date',
                    ),
                ],
              ),
            ),
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
            if (_editController.text.isNotEmpty) {
              final updatedLot = widget.lot.copyWith(
                lotNumber: _editController.text,
                expirationDate: drift.Value(_selectedExpirationDate),
              );
              widget.onSave(updatedLot);
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
