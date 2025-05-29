import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    _lotNumberController.dispose();
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
              child: Row(
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await database.insertLot(
                          LotsCompanion.insert(
                            lotNumber: _lotNumberController.text,
                          ),
                        );
                        _lotNumberController.clear();
                        setState(() {});
                      }
                    },
                    child: const Text('Add Lot'),
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
                            final editController = TextEditingController(
                              text: lot.lotNumber,
                            );
                            return AlertDialog(
                              title: const Text('Edit Lot'),
                              content: TextField(
                                controller: editController,
                                decoration: const InputDecoration(
                                  labelText: 'Lot Number',
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
            ),
          ),
        ],
      ),
    );
  }
}
