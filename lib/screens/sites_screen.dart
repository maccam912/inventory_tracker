import 'package:flutter/material.dart';
import '../database/database.dart';
import '../database/database_provider.dart';

class SitesScreen extends StatefulWidget {
  const SitesScreen({super.key});

  @override
  SitesScreenState createState() => SitesScreenState();
}

class SitesScreenState extends State<SitesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _siteNameController = TextEditingController();

  @override
  void dispose() {
    _siteNameController.dispose();
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
                      controller: _siteNameController,
                      decoration: const InputDecoration(
                        labelText: 'Site Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a site name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await database.insertSite(
                          SitesCompanion.insert(
                            siteName: _siteNameController.text,
                          ),
                        );
                        _siteNameController.clear();
                        setState(() {});
                      }
                    },
                    child: const Text('Add Site'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Site>>(
              future: database.getAllSites(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final sites = snapshot.data ?? [];

                if (sites.isEmpty) {
                  return const Center(child: Text('No sites added yet'));
                }

                return ListView.builder(
                  itemCount: sites.length,
                  itemBuilder: (context, index) {
                    final site = sites[index];
                    return ListTile(
                      title: Text(site.siteName),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await database.deleteSite(site.id);
                          setState(() {});
                        },
                      ),
                      onTap: () {
                        // Edit site dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            final editController = TextEditingController(
                              text: site.siteName,
                            );
                            return AlertDialog(
                              title: const Text('Edit Site'),
                              content: TextField(
                                controller: editController,
                                decoration: const InputDecoration(
                                  labelText: 'Site Name',
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
                                      await database.updateSite(
                                        site.copyWith(
                                          siteName: editController.text,
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
